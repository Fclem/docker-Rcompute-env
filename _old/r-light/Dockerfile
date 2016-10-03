FROM fimm/r-fimm
MAINTAINER clement.fiere@helsinki.fi

# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN apt-get update && apt-get upgrade -y --force-yes
RUN apt-get remove -y --force-yes gcc
RUN apt-get remove -y --force-yes libc-dev
RUN apt-get remove -y --force-yes libc6-dev
RUN apt-get remove -y --force-yes comerr-dev
RUN apt-get remove -y --force-yes krb5-multidev
RUN apt-get remove -y --force-yes libgnutls-dev
RUN apt-get remove -y --force-yes libkrb5-dev
RUN apt-get remove -y --force-yes librtmp-dev
RUN apt-get remove -y --force-yes libssh2-1-dev
RUN apt-get remove -y --force-yes zlib1g-dev
RUN apt-get remove -y --force-yes tk8.5-dev

RUN apt-get autoremove -y --force-yes
RUN apt-get clean -y --force-yes
RUN apt-get autoclean -y --force-yes

RUN rm -fr /var/lib/{apt,dpkg,cache,log}/

RUN rm -fr /usr/java/jre1.8.0_71/ /usr/lib/jvm /usr/lib/python2.7 \
	&& rm -fr /usr/lib/python3.4 /usr/lib/gcc/x86_64-linux-gnu \
	&& rm -fr /usr/lib/openbabel /var/cache
