#!/bin/bash
# A script for packaging lambda deployables prior to deployment

# LAYER WORKFLOW
# get list of layers
echo "starting packaging of lambda layers"
LAYER_FOLDERS=$(ls -d src/lambda/layers/*)

# zip layer payloads
for layer in $LAYER_FOLDERS; do
    echo "zipping layer: $layer"
    zip -r $layer/layer $layer/python/
done
echo "packaging of lambda layers complete"

# FUNCTION WORKFLOW
# get list of functions
echo "starting packaging of lambda functions"
FUNCTION_FOLDERS=$(ls -d src/lambda/functions/*)

# zip function payloads
for func in $FUNCTION_FOLDERS; do
    echo "zipping function: $func"
    cd $func
    zip -r lambda_function.zip lambda_function.py
done
echo "packaging of lambda functions complete"