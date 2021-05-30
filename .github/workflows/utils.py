#!/usr/bin/env python3
import shutil, os
import zipfile

# Set Constants
METHODS_DIR_NAME = 'methods'
RESOURCES_DIR_NAME = 'resources'
TEMP_RESOURCE_FILE = "temp_resource.tf"
TEMPLATES_DIR = ".github/workflows/templates"
LAMBDA_FUNCTION_FILENAME = "lambda_function.py"

"""
    Definition: helper method for appending string as new line in a file
    Inputs: file_path, text_to_append
    Outputs: n/a
"""
def append_new_line(file_name, text_to_append):
    # Open the file in append & read mode ('a+')
    with open(file_name, "a+") as file_object:
        # Append text at the end of file
        file_object.write(text_to_append)

"""
    Definition: helper method for returning a list of sub-directories in a directory
    Inputs: directory (string)
    Outputs: list_of_subdirectories
"""
def get_all_sub_directory_names(directory):
    return [name for name in os.listdir(directory)
            if os.path.isdir(os.path.join(directory, name))]

"""
    Definition: helper method for zipping a lambda deployable
    Inputs: path (/path/to/file/or/directory), target_path (zipfile path without .zip extension)
    Outputs: n/a
"""
def zip_lambda_deployable(path, zip_path):
    
    print("Zipping lambda deployable.")

    # Check if File vs Directory
    is_file = os.path.isfile(path)
    is_directory = os.path.isdir(path)
    
    # get current directory
    orig_dir = os.getcwd()

    # if file, zip file to root
    if is_file:
        print("zipping file --> " + zip_path)

        filename = path[path.rindex('/')+1:]
        directory = path.replace('/' + filename,'')

        # create zip and write file to it
        os.chdir(directory)
        zipObj = zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED)
        zipObj.write(filename)
        zipObj.close()
        
    # else if directory, zip directory
    elif is_directory:
        print("zipping directory --> " + zip_path)

        # create archive
        shutil.make_archive(zip_path, 'zip', path)
    
    # change back to original directory
    os.chdir(orig_dir)