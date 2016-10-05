FROM r-base:latest
MAINTAINER "Clément Fiere" clement.fiere@helsinki.fi

# RUN mkdir /res
COPY root/ /
# ADD install_lib.R /res/

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
	fish \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	python2.7-dev \
	libffi-dev

RUN apt-get install -y --no-install-recommends \
	openjdk-8-jdk \
	openjdk-8-jre \
	r-cran-rjava && \
	R CMD javareconf

RUN apt-get install -y --no-install-recommends \
	libssl-dev

# create a link for python (for some reason it doesn't exist in the base image)
RUN ln /usr/bin/python2.7 /usr/bin/python
# download and install pip
RUN python /res/get-pip.py && pip install --upgrade pip
# install the only python packages required
RUN pip install azure-common azure-nspkg azure-storage

# install all the R libraries
# RUN ["Rscript", "/res/install_lib.R"]
# libpath is /usr/local/lib/R/site-library
ADD lib_list /res/
# TODO DELETE THIS LINE (will recompile everything though)
RUN ["R", "-e", "source('/res/lib_installer.R'); packages('/res/lib_list')"]


RUN apt-get install -y --no-install-recommends \
	r-cran-ggplot2 \
	r-cran-reshape2 \
	r-cran-gplots \
	r-cran-xtable \
	r-cran-dosnow \
	r-cran-catools \
	r-cran-dosnow \
	r-cran-scales

# TODO compact this build

RUN apt-get install -y --no-install-recommends \
	libcurl4-openssl-dev

ADD lib_list_new /res/
RUN ["R", "-e", "source('/res/lib_installer.R'); packages('/res/lib_list_new')"]
