#!/bin/bash
# A script for updating main.tf template with new resources

# Set Constants
TEMP_RESOURCE_FILE="temp_resource.tf"
TEMPLATE_LAMBDA_FUNCTION="resource_lambda_function.tf"
TEMPLATE_LAMBDA_LAYER="resource_lambda_layer.tf"

# Copy Main Template File
cp .github/workflows/templates/main.tf main.tf

# Loop Through Appending Functions
FUNCTION_FOLDERS=$(ls -d src/lambda/functions/*)
for func in $FUNCTION_FOLDERS; do

    # set tokens
    FUNCTION_ZIP_PATH=$func'/lambda_function.zip'
    FUNCTION_NAME=${func//*\/}

    echo "FUNCTION_ZIP_PATH: $FUNCTION_ZIP_PATH"
    echo "FUNCTION_NAME: $FUNCTION_NAME"

    # cp template to temp file
    cp .github/workflows/templates/$TEMPLATE_LAMBDA_FUNCTION $TEMP_RESOURCE_FILE

    # tokenize temp file
    FUNCTION_ZIP_PATH_FOR_SED=$(echo $FUNCTION_ZIP_PATH | sed 's/\//\\\//g')
    sed -i "s/__FUNCTION_ZIP_PATH__/$FUNCTION_ZIP_PATH_FOR_SED/g" $TEMP_RESOURCE_FILE
    sed -i "s/__FUNCTION_NAME__/$FUNCTION_NAME/g" $TEMP_RESOURCE_FILE

    # append contents of temp file to main.tf
    cat $TEMP_RESOURCE_FILE >> main.tf
done




# Loop Through Appending Layers
# LAYER_FOLDERS=$(ls -d src/lambda/layers/*)
# for layer in $LAYER_FOLDERS; do
#     folder_path=$layer'/layer.zip'  
    

# done


# Cleanup
rm -rf $TEMP_RESOURCE_FILE
