FROM fimm/r2:v0
MAINTAINER clement.fiere@helsinki.fi

ENV R_LIBS_USER=/usr/lib/R/site-library

COPY library/ $R_LIBS_USER/

RUN wget https://cran.r-project.org/src/contrib/Archive/robustbase/robustbase_0.9-5.tar.gz && \
	wget https://cran.r-project.org/src/contrib/Archive/sp/sp_1.0-11.tar.gz && \
	R -e "install.packages('/breeze/robustbase_0.9-5.tar.gz', repos = NULL, type='source');" && \
	R -e "install.packages('/breeze/sp_1.0-11.tar.gz', repos = NULL, type='source')" && \
	rm /breeze/robustbase_0.9-5.tar.gz && rm /breeze/sp_1.0-11.tar.gz

