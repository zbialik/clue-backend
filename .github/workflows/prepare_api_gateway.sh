#!/bin/bash
# A script for updating main.tf template with new resources

# Set Constants
WORKSPACE=$(pwd)
METHODS_DIR='methods'
RESOURCES_DIR='resources'
TEMP_RESOURCE_FILE="temp_resource.tf"
TEMPLATES_DIR=".github/workflows/templates"

TEMPLATE_API_GATEWAY_REST_API="${TEMPLATES_DIR}/resources/apigateway_rest_api.tf"
TEMPLATE_API_GATEWAY_RESOURCE="${TEMPLATES_DIR}/resources/apigateway_resource.tf"

# Add API Gateway REST API

# Add API Gateway Resource
LAYER_FOLDERS=$(ls -d ${WORKSPACE}/src/lambda/layers/*)
touch temp.txt
for layer in $LAYER_FOLDERS; do
    cd $layer
    zip -r layer python/
    cd $WORKSPACE
    
    # set tokens
    LAYER_ZIP_PATH=$layer'/layer.zip'  
    LAYER_NAME=${layer//*\/}

    echo "LAYER_ZIP_PATH: $LAYER_ZIP_PATH"
    echo "LAYER_NAME: $LAYER_NAME"

    # also generate dependencies to insert into functions resources later
    line_to_add="aws_lambda_layer_version.${LAYER_NAME}.arn,"
    echo '    '$line_to_add >> temp.txt

    # cp template to temp file
    cp -rf $TEMPLATE_LAMBDA_LAYER $TEMP_RESOURCE_FILE

    # tokenize temp file
    LAYER_ZIP_PATH_FOR_SED=$(echo $LAYER_ZIP_PATH | sed 's/\//\\\//g')
    sed -i "s/__LAYER_ZIP_PATH__/$LAYER_ZIP_PATH_FOR_SED/g" $TEMP_RESOURCE_FILE
    sed -i "s/__LAYER_NAME__/$LAYER_NAME/g" $TEMP_RESOURCE_FILE

    # append contents of temp file to main.tf
    cat $TEMP_RESOURCE_FILE >> main.tf
done

# Cleanup
rm -rf $TEMP_RESOURCE_FILE

cat main.tf
