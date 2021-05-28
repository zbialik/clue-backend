#!/bin/bash
# A script for packaging lambda functions prior to deployment

echo Starting Zip Lambda functions

# get list of layers
LAYER_FOLDERS=$(ls -d src/lambda/layers/*)


# zip layer payloads
zip -r src/lambda/layers/dynamodb_json/layer src/lambda/layers/dynamodb_json/python/

