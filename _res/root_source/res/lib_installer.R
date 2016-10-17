ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = T, repos="http://cran.rstudio.com/")
}

packages <- function(file_){
	pck_list <- unname(as.list(as.data.frame(readLines(file_, warn=F), stringsAsFactors = F))[[1]])
	ipak(pck_list)
	sapply(pck_list, require, character.only = T)
	# sapply(pck_list, require)
}
