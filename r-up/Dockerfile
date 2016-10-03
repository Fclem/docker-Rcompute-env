FROM fimm/r-security-blanket
MAINTAINER clement.fiere@helsinki.fi

# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN apt-get update && apt-get install -y --force-yes python2.7 python2.7-dev libmysqlclient-dev

RUN apt-get install -y --force-yes r-cran-dichromat r-cran-digest r-cran-gdata r-cran-ggplot2 r-cran-gplots r-cran-gtable r-cran-gtools r-cran-labeling r-cran-mass r-cran-munsell r-cran-plotrix r-cran-plyr r-cran-proto r-cran-rcolorbrewer r-cran-rcpp r-cran-rcpparmadillo r-cran-rcppeigen r-cran-rcurl r-cran-reshape r-cran-reshape2 r-cran-rsqlite r-cran-scales r-cran-scatterplot3d r-cran-rmysql
RUN apt-get install -y --force-yes r-cran-abind r-cran-base64enc r-cran-bitops r-cran-boot r-cran-cairodevice r-cran-car r-cran-catools r-cran-chron r-cran-class r-cran-cluster r-cran-coda r-cran-codetools r-cran-colorspace r-cran-combinat r-cran-dbi r-cran-deal r-cran-dosnow r-cran-effects r-cran-epir r-cran-evaluate r-cran-fastcluster r-cran-fbasics r-cran-foreach r-cran-foreign r-cran-formula r-cran-gam r-cran-genabel r-cran-genetics r-cran-gmodels r-cran-gss r-cran-hmisc r-cran-hwriter
RUN apt-get install -y --force-yes r-cran-iterators r-cran-its r-cran-kernsmooth r-cran-lattice r-cran-latticeextra r-cran-lme4 r-cran-lmtest r-cran-maps r-cran-matrix r-cran-memoise r-cran-mgcv r-cran-minqa r-cran-misc3d r-cran-multcomp r-cran-mvtnorm r-cran-nlme r-cran-nnet r-cran-permute r-cran-pscl r-cran-quadprog r-cran-randomforest r-cran-rgl r-cran-rglpk r-cran-rjson r-cran-rms r-cran-robustbase r-cran-rocr r-cran-rpart r-cran-rserve r-cran-runit r-cran-sandwich
RUN apt-get install  -y --force-yes r-cran-slam r-cran-sm r-cran-snow r-cran-stabledist r-cran-statmod r-cran-survival r-cran-th.data r-cran-timedate r-cran-timeseries r-cran-urca r-cran-vegan r-cran-zoo r-bioc-affy r-cran-sp r-cran-sparsem r-cran-spatial r-cran-spatstat r-cran-spc r-cran-stringr r-cran-vcd r-cran-xml r-cran-xtable

RUN apt-get install  -y --force-yes pdftk

WORKDIR /breeze/

# RUN mkdir /usr/local/lib/R/ext-library
ENV R_LIBS_USER=/usr/lib/R/site-library

COPY libs/ $R_LIBS_USER/

ENV DOCK_HOME=/breeze
