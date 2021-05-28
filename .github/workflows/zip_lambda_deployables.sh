#!/bin/bash
# A script for packaging lambda deployables prior to deployment

echo "starting zip of lambda layer"

# get list of layers
LAYER_FOLDERS=$(ls -d src/lambda/layers/*)

# zip layer payloads
for layer in $LAYER_FOLDERS; do
    echo "zipping layer: $layer"
    zip -r $layer/layer $layer/python/
done

echo "zipping of lambda layers complete"
