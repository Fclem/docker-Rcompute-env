FROM r-base:latest
MAINTAINER "Clément Fiere" clement.fiere@helsinki.fi

###
#	IMAGE SPECIFIC
###

# update packages
RUN apt-get update && apt-get upgrade -y

# Python and open-ssl
RUN apt-get install -y --no-install-recommends \
	fish \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	python2.7-dev \
	libffi-dev \
	libssl-dev \
	libcurl4-openssl-dev

# java
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
	r-cran-rjson \
	r-cran-readxl \
	libmariadb-client-lgpl-dev

# custom R library installer
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/res/lib_installer.R /res/
# list of libraries to install
ADD lib_list /res/
# install all remaining R libraries
RUN ["R", "-e", "source('/res/lib_installer.R'); packages('/res/lib_list')"]
# specific version of plotly for compatibility purposes
RUN ["R", "-e", "install.packages('https://cran.r-project.org/src/contrib/Archive/plotly/plotly_3.6.0.tar.gz', repos=NULL, type='source')"]

###
#	FILE SPECIFIC
###

# copy override file and folder structure form build context
# disabled as nothing there ATM
# COPY fs_override/ /

# *LEGACY* Bash container starting script
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/run.sh /
# R custom additional functions
ADD https://raw.githubusercontent.com/Fclem/docker-Rcompute-env/master/_res/root_source/res/dyn_lib_load.R /res/
# git token
ADD fs_override/.git_hub_token_secret /res/
# required packages for the new bootstrap python script
RUN pip install PyGithub plumbum
# New container starting Python script
ADD https://raw.githubusercontent.com/Fclem/py-sandbox/master/docker-bs/container-bootstrap.py /
# makes both scripts executable (just in case if not already)
RUN chmod u+x /run.sh /container-bootstrap.py
# download the whole storage module folder from GitHub, so that the container already has basic storage features
RUN /container-bootstrap.py git_download && rm /res/.git_hub_token_secret

# clean up
RUN apt-get -y autoclean && apt-get -y autoremove \
	&& rm -fr /var/cache/apt/archives/*	/var/lib/apt/lists/*	/tmp/*	/var/tmp/*
