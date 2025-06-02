############ 12 October 2024 ############ 


setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Datasets")

library(lme4)

# Create data
data <- data.frame(
  Patient_ID = factor(c(1,1,2,2,3,3,4,4,5,5)),
  Treatment = factor(c('A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B')),
  Improvement = c(1, 0, 1, 1, 0, 0, 1, 1, 0, 0)
)

# Fit the GLMM
model <- glmer(Improvement ~ Treatment + (1 | Patient_ID), data = data, family = binomial)

# Print summary of the model
summary(model)

