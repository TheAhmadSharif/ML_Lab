setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Project")



# install.packages(c("lmerTest", "MuMIn", "Matrix", "lme4"))
library(Matrix)
library(lme4)

library(stats)

data <- read.csv("olympics-economics.csv")

attach(data)

total_medals = gold + silver + bronze


plot(total_medals, data$gdp)
plot(total_medals, data$population)




head(df)
model <- glmer(total ~ gold + silver + bronze + gdp + population + (1 | country_code), data = df, family = poisson)


summary(model)


packageVersion("Matrix")[1]
packageVersion("lme4")[1]



# Standardize predictor variables
df$gold_std <- scale(df$gold)
df$silver_std <- scale(df$silver)
df$bronze_std <- scale(df$bronze)
df$gdp_std <- scale(df$gdp)
df$population_std <- scale(df$population)

# Fit the GLMM with standardized variables
model <- glmer(total ~ gold_std + silver_std + bronze_std + gdp_std + population_std + (1 | country_code), data = df, family = poisson)


