#!/bin/bash
# A script for packaging lambda deployables prior to deployment

# LAYER WORKFLOW
# get list of layers
WORKSPACE=$(pwd)
echo "starting packaging of lambda layers"
LAYER_FOLDERS=$(ls -d ${WORKSPACE}/src/lambda/layers/*)

# zip layer payloads
for layer in $LAYER_FOLDERS; do
    echo "zipping layer: $layer"
    cd $layer
    zip -r layer python/
done
echo "packaging of lambda layers complete"

# FUNCTION WORKFLOW
# get list of functions
echo "starting packaging of lambda functions"
FUNCTION_FOLDERS=$(ls -d ${WORKSPACE}/src/lambda/functions/*)

# zip function payloads
for func in $FUNCTION_FOLDERS; do
    echo "zipping function: $func"
    cd $func
    zip -r lambda_function.zip lambda_function.py
done
echo "packaging of lambda functions complete"