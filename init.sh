#!/bin/bash
# init script for docker container buildout of breeze-compute env for r2/r3

mkdir -p _res/root/res

echo "azure_pwd_breezedata">_res/root/azure_pwd_breezedata
cat _res/root/azure_pwd_breezedata>_res/root/res/azure_pwd_breezedata

# pip
wget https://bootstrap.pypa.io/get-pip.py -O _res/root/res/get-pip.py 

commit=69d67730434ce7e6b8c35253f4b9bf56a82c479b
repo_url=https://raw.githubusercontent.com/findcomrade/isbio/$commit/isbio/breeze

# azure storeage module
wget $repo_url/azure_storage.py -O _res/root/res/azure_storage.py
# blob interface module
wget $repo_url/blob_storage_module.py -O _res/root/res/blob_storage_module.py
