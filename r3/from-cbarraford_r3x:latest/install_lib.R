ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = T, repos="http://cran.rstudio.com/")
}


packages <- c("ggplot2", "reshape2", "raster", "tools", "doSNOW","gridExtra", "grid", "gplots", "openxlsx", "caTools", "gsubfn", "plotly", "d3heatmap", "drc", "xtable", "minpack.lm")
ipak(packages)
