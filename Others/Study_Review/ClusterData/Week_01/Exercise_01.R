setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Week_01")


# Loading the necessary libraries
library(MASS)


Crabs <- read.table("Crabs.dat.txt", header = TRUE)


attach(Crabs)
colnames(Crabs)

# model_1 <- glm.nb(y ~ factor(color),  data = Crabs)
# model_2 <- glm.nb(y ~ color,  data = Crabs)


model_1 <- glm(y ~ weight, family = poisson, data = Crabs)
model_2 <- glm(y ~ weight + factor(color), family = poisson, data = Crabs)
summary(model_1)
summary(model_2)


# ANOVA

anova(model_2, model_1)
