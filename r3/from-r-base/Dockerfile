FROM r-base:latest
MAINTAINER "Clément Fiere" clement.fiere@helsinki.fi

###
#	IMAGE SPECIFIC
###

# update packages
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
	fish \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	python2.7-dev

RUN apt-get install -y --no-install-recommends \
	libffi-dev \
	libssl-dev \
	libcurl4-openssl-dev

RUN apt-get install -y --no-install-recommends \
	openjdk-8-jdk \
	openjdk-8-jre \
	r-cran-rjava && \
	R CMD javareconf

# create a link for python (for some reason it doesn't exist in the base image)
RUN ln /usr/bin/python2.7 /usr/bin/python

# pip installer
ADD https://bootstrap.pypa.io/get-pip.py /res/
# download and install pip
RUN python /res/get-pip.py && pip install --upgrade pip
# install the only python packages required
RUN pip install azure-common azure-nspkg azure-storage

# install all R libraries available from aptitude
RUN apt-get install -y --no-install-recommends \
	r-cran-ggplot2 \
	r-cran-reshape2 \
	r-cran-gplots \
	r-cran-xtable \
	r-cran-dosnow \
	r-cran-catools \
	r-cran-dosnow \
	r-cran-scales \
	r-cran-rjson

# custom R library installer
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/res/lib_installer.R /res/
# list of libraries to install
ADD lib_list /res/
# install all remaining R libraries
RUN ["R", "-e", "source('/res/lib_installer.R'); packages('/res/lib_list')"]

###
#	FILE SPECIFIC
###

# copy override file and folder structure form build context
COPY fs_override/ /

# Bash container starting script
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/run.sh /
# R custom additional functions
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/res/dyn_lib_load.R /res/
# Python azure blob storage
ADD https://raw.githubusercontent.com/Fclem/isbio2/master/isbio/breeze/azure_storage.py /res/
ADD https://raw.githubusercontent.com/Fclem/isbio2/master/isbio/breeze/blob_storage_module.py /res/

