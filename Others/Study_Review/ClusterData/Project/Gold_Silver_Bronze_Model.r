setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Project")

# Load necessary library
library(dplyr)

# Load the dataset
data <- read.csv("olympics-economics.csv")
data
# Log-transform GDP and Population
data <- data %>%
  mutate(log_gdp = log(gdp),
         log_population = log(population))

# Fit Poisson regression models
gold_model <- glm(gold ~ log_gdp + log_population, data = data, family = poisson(link = "log"))
silver_model <- glm(silver ~ log_gdp + log_population, data = data, family = poisson(link = "log"))
bronze_model <- glm(bronze ~ log_gdp + log_population, data = data, family = poisson(link = "log"))

# Summarize the models
summary(gold_model)
summary(silver_model)
summary(bronze_model)

exp(coef(gold_model))   
exp(coef(silver_model)) 
exp(coef(bronze_model))  
