#!/bin/bash
# init script for docker container buildout of breeze-compute env for r2/r3

echo "azure_pwd_breezedata">_res/root/azure_pwd_breezedata
cat _res/root/azure_pwd_breezedata>_res/root/res/azure_pwd_breezedata

# wget get-pip.py _res/root/res/get-pip.py 
# wget azure_storage.py _res/root/res/azure_storage.py
# wget blob_storage_module.py _res/root/res/blob_storage_module.py
