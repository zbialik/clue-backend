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
TERRAFORM_TEMPLATE_PATH = WORKSPACE + '/main-test.tf'
TEMPLATE_LAMBDA_FUNCTION= utils.TEMPLATES_DIR + "/resources/lambda_function.tf"
TEMPLATE_LAMBDA_LAYER= utils.TEMPLATES_DIR + "/resources/lambda_layer.tf"

def lamda_worflow():

    def layers_worfklow():
        layers_directories = utils.get_all_sub_directory_names(LAMBDA_LAYERS_DIR)
        for layer in layers_directories:
            # 1. Zip Lambda Layer Deployable
            zip_path = LAMBDA_LAYERS_DIR + '/' + layer + '/layer'
            target_dir = LAMBDA_LAYERS_DIR + '/' + layer + '/python'

            print("target_dir: " + target_dir)
            print("zip_path: " + zip_path + '.zip')
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
            print('executing: process_lambda_functions_dirs(%s)' % search_dir)
            # path_to_methods must end with /methods
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
                        # print('zipping '+ function_name +' function to: ' + function_zip_path)
                        # utils.zip_lambda_deployable(function_folder_path + '/' + utils.LAMBDA_FUNCTION_FILENAME, function_zip_path)

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

    # DynamoDB Workflow

    # utils.zip_lambda_deployable('/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.py','/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip')

if __name__ == "__main__":
    main()