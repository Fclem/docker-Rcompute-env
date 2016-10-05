ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = T, repos="http://cran.rstudio.com/")
  require(new.pkg)
}


packages <- c("rJava", "xlsx", "Nozzle.R1", "ggplot2", "reshape2", "raster", "tools", "doSNOW","gridExtra", "grid", "gplots", "openxlsx", "caTools", "gsubfn", "plotly", "d3heatmap", "drc", "xtable", "minpack.lm")
ipak(packages)
