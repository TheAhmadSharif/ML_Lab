packages <- c("fpp", "forecast", "tseries", "ggplot2", "dplyr", "plyr", "Hmisc", "lme4", "arm", "lattice", "lavaan")

for(p in packages){
  if(!require(p,character.only = TRUE)) install.packages(p, repos="http://cran.us.r-project.org", dependencies = TRUE)
  library(p,character.only = TRUE)
}
