FROM fimm/r3:base1
MAINTAINER clement.fiere@helsinki.fi

RUN apt-get update && apt-get install -y openjdk-8-jdk openjdk-8-jre r-cran-rjava && R CMD javareconf

#RUN wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=114681 \
#	&& mv AutoDL?BundleId=114681 java.tar.gz \
#	&& mkdir /usr/java && mv java.tar.gz /usr/java && cd /usr/java \
#	&& tar zxvf java.tar.gz \
#	&& rm java.tar.gz

#COPY ./jdk.tar.gz /usr/java

#RUN cd /usr/java \
#	&& tar zxvf jdk.tar.gz \
#	&& rm jdk.tar.gz

ADD install_lib2.R /breeze/
RUN ["Rscript", "/breeze/install_lib2.R"]
