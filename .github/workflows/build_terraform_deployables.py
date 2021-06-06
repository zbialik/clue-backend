#!/usr/bin/env python3
"""
A python script for preparing lambda deployables by:
    - zipping lambda deployables
    - updating terraform template for lambda portions
"""
import utils
import shutil, os

# set local variables
WORKSPACE = os.getcwd()
LAMBDA_LAYERS_DIR = WORKSPACE + '/src/lambda/layers'
TERRAFORM_TEMPLATE_PATH = WORKSPACE + '/main.tf'
TEMPLATE_LAMBDA_FUNCTION= utils.TEMPLATES_DIR + "/resources/lambda_function.tf"
TEMPLATE_LAMBDA_LAYER= utils.TEMPLATES_DIR + "/resources/lambda_layer.tf"
TEMPLATE_API_GATEWAY_RESOURCE= utils.TEMPLATES_DIR + "/resources/apigateway_resource.tf"
TEMPLATE_API_GATEWAY_REST_API= utils.TEMPLATES_DIR + "/resources/apigateway_rest_api.tf"
TEMPLATE_API_GATEWAY_INTEGRATION= utils.TEMPLATES_DIR + "/resources/api_lambda_integration.tf"

# Set Custom Variables
API_GATEWAY_REST_API_NAME = 'clue-backend'
ROOT_RESOURCE_NAME = 'api_gateway'

def api_gateway_workflow():
    def gateway_resource_workflow():
        def process_resources(path_to_resources):

            # Get Parent Resource ID for Resource Template Token
            path_to_resources = path_to_resources.rstrip('/')
            parent_resource = path_to_resources.split('/')[-2]

            if parent_resource == ROOT_RESOURCE_NAME:
                parent_resource_id_variable = 'aws_api_gateway_rest_api.' + API_GATEWAY_REST_API_NAME + '.root_resource_id'
            else:
                parent_resource_id_variable = 'aws_api_gateway_resource.' + parent_resource + '.id'
            
            if os.path.isdir(path_to_resources):
                resource_folders = utils.get_all_sub_directory_names(path_to_resources)
                for resource in resource_folders:
                    
                    # TODO: refactor/rename 'resources' to 'paths' to match actual meaning
                    path_part = resource
                    if ("{" in resource) or ("}" in resource):
                        resource = resource.replace('{','').replace('}','')
                    
                    print('processing resource: ' + resource)
                    
                    # 1. Update Terraform Template for API Gateway Resource
                    utils.append_new_line(TERRAFORM_TEMPLATE_PATH, '\n')
                    with open(TEMPLATE_API_GATEWAY_RESOURCE, 'r') as reader:
                        for line in reader:
                            # token replacement for line of template
                            line_to_append = line.replace('__API_GATEWAY_RESOURCE_NAME__',resource).replace('__API_GATEWAY_REST_API_NAME__',API_GATEWAY_REST_API_NAME).replace('__PARENT_RESOURCE_ID_VARIABLE__',parent_resource_id_variable).replace('__API_GATEWAY_PATH_PART__',path_part)
                            utils.append_new_line(TERRAFORM_TEMPLATE_PATH, line_to_append)
                    
                    # 2. Recurse through Subresources
                    subresources_folder_path = path_to_resources + '/' + resource + '/' + utils.RESOURCES_DIR_NAME
                    process_resources(subresources_folder_path)
        
        print('starting api gateway "resource" workflow')

        # Loop over all API Resources
        search_dir = WORKSPACE + '/src/api_gateway/' + utils.RESOURCES_DIR_NAME
        process_resources(search_dir)
    
    def gateway_rest_api_workflow():
        print('starting api gateway "rest api" workflow')
        with open(TEMPLATE_API_GATEWAY_REST_API, 'r') as reader:
            for line in reader:
                line_to_append = line.replace('__API_GATEWAY_REST_API_NAME__',API_GATEWAY_REST_API_NAME)
                utils.append_new_line(TERRAFORM_TEMPLATE_PATH, line_to_append)
    
    def gateway_integration_workflow():
        def process_methods(path_to_resource):
            path_to_methods = path_to_resource.rstrip('/') + '/' + utils.METHODS_DIR_NAME
            path_to_resources = path_to_resource.rstrip('/') + '/' + utils.RESOURCES_DIR_NAME
            resource_name = path_to_methods.split('/')[-2]

            # Process all methods for resource
            if os.path.isdir(path_to_methods):
                method_folders = utils.get_all_sub_directory_names(path_to_methods)
                for method in method_folders:

                    # 1. Get Lambda Function Name for API Gateway Integration
                    method_folder_path = path_to_methods + '/' + method
                    function_name = utils.get_all_sub_directory_names(method_folder_path)[0] # only one function per method
                    print('processing api-gateway integration for function: ' + function_name)

                    # 2. Update Terraform Template for AWS API Gateway Integration
                    utils.append_new_line(TERRAFORM_TEMPLATE_PATH, '\n')
                    with open(TEMPLATE_API_GATEWAY_INTEGRATION, 'r') as reader:
                        for line in reader:
                            # token replacement for line of template
                            line_to_append = line.replace('__API_GATEWAY_RESOURCE_NAME__',resource_name).replace('__API_GATEWAY_REST_API_NAME__',API_GATEWAY_REST_API_NAME).replace('__API_GATEWAY_HTTP_METHOD__',method.upper()).replace('__FUNCTION_NAME__',function_name)
                            utils.append_new_line(TERRAFORM_TEMPLATE_PATH, line_to_append)
            
            # Recusively process all subresources
            if os.path.isdir(path_to_resources):
                subresources = utils.get_all_sub_directory_names(path_to_resources)

                for subresource in subresources:
                    path_to_subresource = path_to_resources + '/' + subresource
                    process_methods(path_to_subresource)
        
        print('starting api gateway / lambda "integration" workflow')

        # Loop over all API Resources
        methods_dir = WORKSPACE + '/src/api_gateway'
        process_methods(methods_dir)
    
    # append API Gateway - Rest API template
    gateway_rest_api_workflow()

    # append API Gateway - Resource template
    gateway_resource_workflow()

    # append API Gateway - Integration template
    gateway_integration_workflow()



def lamda_worflow():
    def layers_worfklow():
        layers_directories = utils.get_all_sub_directory_names(LAMBDA_LAYERS_DIR)
        for layer in layers_directories:
            # 1. Zip Lambda Layer Deployable
            zip_path = LAMBDA_LAYERS_DIR + '/' + layer + '/layer'
            target_dir = LAMBDA_LAYERS_DIR + '/' + layer + '/python'

            utils.zip_lambda_deployable(target_dir, zip_path)

            # 2. Update Terraform Template for Lambda Layer
            utils.append_new_line(TERRAFORM_TEMPLATE_PATH, '\n')
            with open(TEMPLATE_LAMBDA_LAYER, 'r') as reader:
                for line in reader:
                    # token replacement for line of template
                    line_to_append = line.replace('__LAYER_NAME__',layer).replace('__LAYER_ZIP_PATH__',zip_path + '.zip')
                    utils.append_new_line(TERRAFORM_TEMPLATE_PATH, line_to_append)

    def functions_worfklow():
        def process_lambda_functions_dirs(search_dir):
            def process_method_functions(path_to_methods):
                if os.path.isdir(path_to_methods):
                    method_folders = utils.get_all_sub_directory_names(path_to_methods)
                    for method in method_folders:

                        # 1. Zip Lambda Function Deployable
                        method_folder_path = path_to_methods + '/' + method

                        function_name = utils.get_all_sub_directory_names(method_folder_path)[0] # only one function per method
                        print('processing function: ' + function_name)
                        function_folder_path = method_folder_path + '/' + function_name
                        
                        function_zip_path = function_folder_path + '/lambda_function.zip'
                        utils.zip_lambda_deployable(function_folder_path + '/' + utils.LAMBDA_FUNCTION_FILENAME, function_zip_path)

                        # 2. Update Terraform Template for Lambda Function
                        utils.append_new_line(TERRAFORM_TEMPLATE_PATH, '\n')
                        with open(TEMPLATE_LAMBDA_FUNCTION, 'r') as reader:
                            for line in reader:
                                # token replacement for line of template
                                line_to_append = line.replace('__FUNCTION_NAME__',function_name).replace('__FUNCTION_ZIP_PATH__',function_zip_path)
                                utils.append_new_line(TERRAFORM_TEMPLATE_PATH, line_to_append)

            # Process 'methods' folder for gateway resource
            methods_folder_path = search_dir + '/' + utils.METHODS_DIR_NAME
            process_method_functions(methods_folder_path)

            # If there are subresources, update search_dir and recurse through resources
            resources_folder_path = search_dir + '/' + utils.RESOURCES_DIR_NAME
            if os.path.isdir(resources_folder_path):
                resource_sub_directories = utils.get_all_sub_directory_names(resources_folder_path)
                for resource_dir in resource_sub_directories:
                    print('iterating through functions for resource: ' + resource_dir)
                    process_lambda_functions_dirs(resources_folder_path + '/' + resource_dir)
        
        search_dir = WORKSPACE + '/src/api_gateway'
        process_lambda_functions_dirs(search_dir)

    
    # Layers Workflow
    layers_worfklow()

    # Functions Workflow
    functions_worfklow()

def main():

    # Lambda Worfklow
    lamda_worflow()
    
    # API Gateway Workflow
    api_gateway_workflow()

    # DynamoDB Workflow

    a_file = open(TERRAFORM_TEMPLATE_PATH)
    lines = a_file.readlines()
    for line in lines:
        print(line)
    
if __name__ == "__main__":
    main()