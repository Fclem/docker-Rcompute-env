FROM fimm/ubuntu-mod:15.10
#FROM fimm/r-security-blanket
MAINTAINER clement.fiere@helsinki.fi

RUN mkdir -p /home/docker/R

WORKDIR /home/docker/R
RUN wget http://cran.r-project.org/bin/linux/ubuntu/precise/r-base_2.15.3.orig.tar.gz \
	&& tar zxvf r-base_2.15.3.orig.tar.gz

WORKDIR /home/docker/R/R-2.15.3/
RUN ./configure --with-x=no --enable-R-shlib=yes
RUN make
RUN make check
RUN make install
RUN apt-get update && apt-get install -y --force-yes mysql-common>=5.0.51a-24+lenny5 \
	&& wget "http://archive.debian.org/debian/pool/main/m/mysql-dfsg-5.0/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb" \
	&& dpkg -i libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb \
	&& rm libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb
RUN rm -fr /home/docker/R

RUN apt-get update && apt-get install -y --force-yes libxmlsec1 libgfortran-4.7-dev gcc-4.9

RUN wget http://ftp.fi.debian.org/debian/pool/main/g/gcc-4.1/gcc-4.1-base_4.1.2-29_amd64.deb \
        && dpkg -i gcc-4.1-base_4.1.2-29_amd64.deb \
	&& rm gcc-4.1-base_4.1.2-29_amd64.deb

RUN wget http://ftp.de.debian.org/debian-archive/debian/pool/main/g/gcc-4.1/libgfortran1_4.1.1-21_amd64.deb \
        && dpkg -i --ignore-depends=gcc-4.1-base libgfortran1_4.1.1-21_amd64.deb \
	&& rm libgfortran1_4.1.1-21_amd64.deb

WORKDIR /breeze/
RUN rm -fr /home/docker/*

RUN wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=114681 \
	&& mv AutoDL?BundleId=114681 java.tar.gz \
	&& mkdir /usr/java && mv java.tar.gz /usr/java && cd /usr/java \
	&& tar zxvf java.tar.gz \
	&& rm java.tar.gz

COPY ./jdk.tar.gz /usr/java

RUN cd /usr/java \
	&& tar zxvf jdk.tar.gz \
	&& rm jdk.tar.gz

RUN apt-get -fy --force-yes install

ENV JAVA_HOME=/usr/java/jdk1.8.0_72/
ENV PATH=$PATH:$JAVA_HOME

RUN R CMD javareconf

RUN apt-get install -y --force-yes libpixman-1-0 libxcb-render0 libxcb-shm0 gcc-4.1-base libgmp-dev libpython2.7-minimal libpython2.7-stdlib

RUN apt-get update && apt-get install -y --force-yes curl libcurl3 libpython2.7 libgsl0ldbl libcairo2 libopenbabel4 libgmp3-dev

RUN apt-get update && apt-get install -y --force-yes python2.7 python2.7-dev

RUN apt-get install r-cran-dichromat r-cran-digest r-cran-gdata r-cran-ggplot2 r-cran-gplots r-cran-gtable r-cran-gtools r-cran-labeling r-cran-mass r-cran-munsell r-cran-plotrix r-cran-plyr r-cran-proto r-cran-rcolorbrewer r-cran-rcpp r-cran-rcpparmadillo r-cran-rcppeigen r-cran-rcurl r-cran-reshape r-cran-reshape2 r-cran-rsqlite r-cran-scales r-cran-scatterplot3d r-cran-sp r-cran-sparsem r-cran-spatial r-cran-spatstat r-cran-spc r-cran-stringr r-cran-vcd r-cran-xml r-cran-xtable
RUN apt-get install r-cran-abind r-cran-base64enc r-cran-bitops r-cran-boot r-cran-cairodevice r-cran-car r-cran-catools r-cran-chron r-cran-class r-cran-cluster r-cran-coda r-cran-codetools r-cran-colorspace r-cran-combinat r-cran-dbi r-cran-deal r-cran-dosnow r-cran-effects r-cran-epir r-cran-evaluate r-cran-fastcluster r-cran-fbasics r-cran-foreach r-cran-foreign r-cran-formula r-cran-gam r-cran-genabel r-cran-genetics r-cran-gmodels r-cran-gss r-cran-hmisc r-cran-hwriter
RUN apt-get install r-cran-iterators r-cran-its r-cran-kernsmooth r-cran-lattice r-cran-latticeextra r-cran-lme4 r-cran-lmtest r-cran-maps r-cran-matrix r-cran-memoise r-cran-mgcv r-cran-minqa r-cran-misc3d r-cran-multcomp r-cran-mvtnorm r-cran-nlme r-cran-nnet r-cran-permute r-cran-pscl r-cran-quadprog r-cran-randomforest r-cran-rgl r-cran-rglpk r-cran-rjava r-cran-rjson r-cran-rms r-cran-rmysql r-cran-robustbase r-cran-rocr r-cran-rpart r-cran-rserve r-cran-runit r-cran-sandwich
RUN apt-get install  r-cran-slam r-cran-sm r-cran-snow r-cran-stabledist r-cran-statmod r-cran-survival r-cran-th.data r-cran-timedate r-cran-timeseries r-cran-urca r-cran-vegan r-cran-zoo

RUN mkdir /res && mkdir /res/lib_set

COPY libs/*.R /res/
COPY libs/*.sh /res/
COPY libs/sup/*.sh /res/lib_set/

WORKDIR /res/lib_set

RUN ./lib_p0.sh;exit 0
RUN ./lib_p1.sh;exit 0
RUN ./lib_p2.sh;exit 0
RUN ./lib_p3.sh;exit 0
RUN ./lib_p4.sh;exit 0
RUN ./lib_p5.sh;exit 0
RUN ./lib_p6.sh;exit 0
RUN ./lib_p7.sh;exit 0
RUN ./lib_p8.sh;exit 0
RUN ./lib_p9.sh;exit 0
RUN ./lib_p10.sh;exit 0
RUN ./lib_p11.sh;exit 0
RUN ./lib_p12.sh;exit 0
RUN ./lib_p13.sh;exit 0
RUN ./lib_p14.sh;exit 0
RUN ./lib_p15.sh;exit 0
RUN ./lib_p16.sh;exit 0
RUN ./lib_p17.sh;exit 0
RUN ./lib_p18.sh;exit 0
RUN ./lib_p19.sh;exit 0
RUN ./lib_p20.sh;exit 0
RUN ./lib_p21.sh;exit 0
RUN ./lib_p22.sh;exit 0
RUN ./lib_p23.sh;exit 0
RUN ./lib_p24.sh;exit 0
RUN ./lib_p25.sh;exit 0
RUN ./lib_p26.sh;exit 0
RUN ./lib_p27.sh;exit 0
RUN ./lib_p28.sh;exit 0
RUN ./lib_p29.sh;exit 0
RUN ./lib_p30.sh;exit 0
RUN ./lib_p31.sh;exit 0
RUN ./lib_p32.sh;exit 0
RUN ./lib_p33.sh;exit 0
RUN ./lib_p34.sh;exit 0
RUN ./lib_p35.sh;exit 0
RUN ./lib_p36.sh;exit 0
RUN ./lib_p37.sh;exit 0
RUN ./lib_p38.sh;exit 0
RUN ./lib_p39.sh;exit 0
RUN ./lib_p40.sh;exit 0
RUN ./lib_p41.sh;exit 0

WORKDIR /breeze/

