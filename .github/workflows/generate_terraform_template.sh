#!/bin/bash
# A script for updating main.tf template with new resources

# Set Constants
WORKSPACE=$(pwd)
METHODS_DIR='methods'
RESOURCES_DIR='resources'
TEMP_RESOURCE_FILE="temp_resource.tf"
TEMPLATES_DIR=".github/workflows/templates"
TEMPLATE_LAMBDA_FUNCTION="${TEMPLATES_DIR}/resources/lambda_function.tf"
TEMPLATE_LAMBDA_LAYER="${TEMPLATES_DIR}/resources/lambda_layer.tf"

# Copy Main Template File
cp ${TEMPLATES_DIR}/main.tf main.tf

# Loop Through Appending Layers
LAYER_FOLDERS=$(ls -d ${WORKSPACE}/src/lambda/layers/*)
touch temp.txt
for layer in $LAYER_FOLDERS; do
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

# remove final comma for layer dependencies
sed -i '$s/,$//' < temp.txt


# Recursively Append Functions and API Gateway Integrations
search_dir='src/api_gateway'
cmd="ls $search_dir"
CHECK_DIR=$($cmd)
# count=0

# Recurse through resources directories
while [[ "$CHECK_DIR" == *"$RESOURCES_DIR"* ]]; do
    # count=$((count+1))


    # loop through functions for the given resources
    FUNCTION_FOLDERS=$(ls -d $search_dir/methods/*/*)
    for func in $FUNCTION_FOLDERS; do
        appendLambdaFunctionResource() $func
    done

    



    echo "api_gateway subdirectory contains 'resources' dir - recursing through subdirectories"
    cmd=$cmd'/*/'
    CHECK_DIR=$($cmd)
done



# Helper function for appending function to main.tf
appendLambdaFunctionResource() {
    FUNCTION_DIRECTORY=$1

    # set tokens
    FUNCTION_ZIP_PATH=$FUNCTION_DIRECTORY'/lambda_function.zip'
    FUNCTION_NAME=${FUNCTION_DIRECTORY//*\/}

    echo "FUNCTION_ZIP_PATH: $FUNCTION_ZIP_PATH"
    echo "FUNCTION_NAME: $FUNCTION_NAME"

    # cp template to temp file
    cp -rf $TEMPLATE_LAMBDA_FUNCTION $TEMP_RESOURCE_FILE

    # tokenize temp file
    FUNCTION_ZIP_PATH_FOR_SED=$(echo $FUNCTION_ZIP_PATH | sed 's/\//\\\//g')
    sed -i "s/__FUNCTION_ZIP_PATH__/$FUNCTION_ZIP_PATH_FOR_SED/g" $TEMP_RESOURCE_FILE
    sed -i "s/__FUNCTION_NAME__/$FUNCTION_NAME/g" $TEMP_RESOURCE_FILE

    # insert layer dependencies into function resource
    sed -i '/__LAYERS_ARN_LIST__/r temp.txt' $TEMP_RESOURCE_FILE
    sed -i 's/__LAYERS_ARN_LIST__//g' $TEMP_RESOURCE_FILE

    # append contents of temp file to main.tf
    cat $TEMP_RESOURCE_FILE >> main.tf
}

# # Loop Through Appending Functions
# FUNCTION_FOLDERS=$(ls -d src/lambda/functions/*)
# for func in $FUNCTION_FOLDERS; do

#     # set tokens
#     FUNCTION_ZIP_PATH=$func'/lambda_function.zip'
#     FUNCTION_NAME=${func//*\/}

#     echo "FUNCTION_ZIP_PATH: $FUNCTION_ZIP_PATH"
#     echo "FUNCTION_NAME: $FUNCTION_NAME"

#     # cp template to temp file
#     cp -rf $TEMPLATE_LAMBDA_FUNCTION $TEMP_RESOURCE_FILE

#     # tokenize temp file
#     FUNCTION_ZIP_PATH_FOR_SED=$(echo $FUNCTION_ZIP_PATH | sed 's/\//\\\//g')
#     sed -i "s/__FUNCTION_ZIP_PATH__/$FUNCTION_ZIP_PATH_FOR_SED/g" $TEMP_RESOURCE_FILE
#     sed -i "s/__FUNCTION_NAME__/$FUNCTION_NAME/g" $TEMP_RESOURCE_FILE

#     # insert layer dependencies into function resource
#     sed -i '/__LAYERS_ARN_LIST__/r temp.txt' $TEMP_RESOURCE_FILE
#     sed -i 's/__LAYERS_ARN_LIST__//g' $TEMP_RESOURCE_FILE

#     # append contents of temp file to main.tf
#     cat $TEMP_RESOURCE_FILE >> main.tf
# done

# Cleanup
rm -rf $TEMP_RESOURCE_FILE

cat main.tf
