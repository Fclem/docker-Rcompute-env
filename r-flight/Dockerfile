FROM fimm/r-light:candidate
MAINTAINER clement.fiere@helsinki.fi

WORKDIR /breeze/

ENV R_LIBS_USER=/usr/lib/R/site-library

COPY libs/ $R_LIBS_USER/
ENV DOCK_HOME=/breeze
