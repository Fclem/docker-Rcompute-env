FROM busybox

RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get upgrade && apt-get install -y gcc libc-dev && apt-get install libc6 libc6-dev && apt-get install -y libcomerr2 \
	comerr-dev krb5-multidev \
	&& apt-get install -y \
	gfortran-4.7 libgnutls-dev libkrb5-dev librtmp-dev libssh2-1-dev zlib1g-dev tk8.5-dev \
	&& apt-get install -y \
	gcc gfortran libreadline-dev libxml2-dev libcurl4-gnutls-dev wget
