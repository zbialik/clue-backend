#!/bin/bash
# A script for updating main.tf template with new resources

LAYER_FOLDERS=$(ls -d src/lambda/layers/*)

# Copy Template File
cp .github/workflows/templates/main.tf main.tf

# Loop Through Appending Layers


# Loop Through Appending Functions

