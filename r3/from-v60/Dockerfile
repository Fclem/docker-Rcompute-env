FROM fimm/r3:v60
MAINTAINER "Clément Fiere" clement.fiere@helsinki.fi

###
#	FILE SPECIFIC
###

# updates scripts
ADD fs_override/.git_hub_token_secret /res/
RUN rm /res/azure_storage.py /res/blob_storage_module.py
# and the bootsrap file
ADD https://raw.githubusercontent.com/Fclem/py-sandbox/master/docker-bs/container-bootstrap.py /
RUN chmod ug+rx /container-bootstrap.py && /container-bootstrap.py git_download && rm /res/.git_hub_token_secret
