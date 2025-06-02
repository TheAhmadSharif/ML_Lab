setwd("/home/ahmad/Desktop/2023_2024/ClusterData/Week_01")


# Loading the necessary libraries
library(MASS)
homic <- read.table("Homicides.dat.txt", header = TRUE)

n <- table(homic$race)
tb <- table(homic$count, homic$race)
colnames(tb) <- c("white", "black")
# Fitted values for the Poisson distribution
mod.pois <- glm(count ~ race, family = poisson, homic)
mu.pois.black <- exp(sum(mod.pois$coef))
mu.pois.white <- exp(mod.pois$coef[1])
tb.pois <- round(cbind(n[1]* dpois(0:6, mu.pois.white),
                       n[2] * dpois(0:6, mu.pois.black)), 1)
# Fitted values for the negative binomial distributin

library(MASS)
mod.nb <- glm.nb(count ~ race, homic)
mu.nb.black <- exp(sum(mod.nb$coef))
mu.nb.white <- exp(mod.nb$coef[1])



tb.nb <- round(cbind(n[1]* dnbinom(0:6, mu = mu.nb.white, size = mod.nb$theta),
                     n[2] * dnbinom(0:6, mu = mu.nb.black, size = mod.nb$theta)), 1)
dimnames(tb.nb) <- dimnames(tb.pois) <- dimnames(tb)
# Compare Table 7.5 in Agresti
cbind(tb, tb.pois, tb.nb)


############### 06 ##############

model <- glm(count ~ race, family = poisson, data = homic)
summary(model)

############### 06 ##############

model_nb <- glm.nb(count ~ race, data = homic)
summary(model_nb)


