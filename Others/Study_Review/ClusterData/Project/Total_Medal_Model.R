setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Project")


required_packages <- c("lmerTest", "MuMIn", "Matrix", "lme4")
packages_to_install <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]


if (length(packages_to_install) > 0) {
  install.packages(packages_to_install)
}

# Load all required packages
lapply(required_packages, require, character.only = TRUE)

########################################################
########################################################


library(Matrix)
library(lme4)
library(stats)



df <- read.csv("olympics-economics.csv")
attach(df)
plot(df$population, df$gdp)


plot(df$gold, df$gdp)


head(df)


# Standardize predictor variables
df$gold_std <- scale(df$gold)
df$silver_std <- scale(df$silver)
df$bronze_std <- scale(df$bronze)
df$gdp_std <- scale(df$gdp)
df$population_std <- scale(df$population)

# Fit the GLMM with standardized variables
model <- glmer(total ~ gdp_std + population_std + (1 | country_code), 
               data = df, family = poisson)

summary(model)


# Predicted values (response scale)
predicted <- predict(model, type = "response")

# Raw residuals
raw_residuals <- df$total - predicted

# Pearson residuals
pearson_residuals <- raw_residuals / sqrt(predicted)

# Deviance residuals
deviance_residuals <- residuals(model, type = "deviance")

# Summary of residuals
summary(raw_residuals)
summary(pearson_residuals)
summary(deviance_residuals)

