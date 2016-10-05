FROM cbarraford/r3x:latest
MAINTAINER clement.fiere@helsinki.fi

RUN mkdir /breeze
ADD install_lib.R /breeze/

# RUN R CMD BATCH /breeze/install_lib.R
# libpath is /usr/local/lib/R/site-library
RUN ["Rscript", "/breeze/install_lib.R"]

RUN apt-get install -y fish python2.7-dev libffi-dev

COPY root/ /
RUN chmod u+x /run.sh /res/azure_storage.py

RUN python /res/get-pip.py

RUN pip install azure-common azure-nspkg azure-storage

RUN wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=114681 \
	&& mv AutoDL?BundleId=114681 java.tar.gz \
	&& mkdir /usr/java && mv java.tar.gz /usr/java && cd /usr/java \
	&& tar zxvf java.tar.gz \
	&& rm java.tar.gz

COPY ./jdk.tar.gz /usr/java

RUN cd /usr/java \
	&& tar zxvf jdk.tar.gz \
	&& rm jdk.tar.gz

ADD install_lib2.R /breeze/
RUN ["Rscript", "/breeze/install_lib2.R"]
