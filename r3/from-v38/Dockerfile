FROM fimm/r3:v38
MAINTAINER "Clément Fiere" clement.fiere@helsinki.fi

###
#	FILE SPECIFIC
###

RUN pip install PyGithub plumbum

ADD fs_override/.git_hub_token_secret /res/
RUN rm /res/azure_storage.py /res/blob_storage_module.py

ADD https://raw.githubusercontent.com/Fclem/py-sandbox/master/docker-bs/container-bootstrap.py /
RUN chmod ug+rx /container-bootstrap.py && /container-bootstrap.py git_download && rm /res/.git_hub_token_secret
