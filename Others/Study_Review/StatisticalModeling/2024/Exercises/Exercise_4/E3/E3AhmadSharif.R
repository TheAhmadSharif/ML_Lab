### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 03
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
if(!require(nortest)){
  install.packages("nortest")
  library(nortest)
}
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

data<-read.table("ozone.txt", header=TRUE, sep="\t", dec=".")
data 


##1) a) Which model fits the best to the data if the choice of model is done based
## on the AIC value?
 
# i. identity
attach(data)
rad = data$rad
temp = data$temp
wind = data$wind

gaussian.model <- glm(data$ozone~ rad + temp + wind, family=gaussian(link="identity"), data=data)
pearson_residuals <- residuals(gaussian.model, type = "pearson")
pearson_residuals
plot(qnorm(ppoints(length(pearson_residuals))), sort(pearson_residuals), 
     xlab = "Expected Normal Quantiles", ylab = "Ordered Pearson Residuals")
abline(0, 1, col = "red")

###############################
########## Inverse Gaussian
###############################
inverse_gaussian.model <- glm(data$ozone~ rad + temp + wind, family = inverse.gaussian(link = "identity"), data = data)
inverse_gaussian.model 
inverse_gaussian_pearson_residuals <- residuals(inverse_gaussian.model, type = "pearson")


###############################
########## Gamma 
##############################


gama.model <- glm(data$ozone~ rad + temp + wind, family=Gamma(link="log"), data=data)
gama.model 
gamma_pearson_residuals <- residuals(gama.model, type = "pearson")


summary(gaussian.model)
summary(gama.model)
summary(inverse_gaussian.model)


## ii. Yi ∼ Gamma(µi, φ) Gamma is better. 


### c)  Regardless of your solutions to (a) and (b), let us assume Yi ∼ Gamma(µi, φ)

# Fit the GLM model


gama.model <- glm(data$ozone~ rad + temp + wind, data = data, family = gaussian(link = "log"))

coef_sum <- coef(gama.model)[2] + coef(gama.model)[3]
coef_sum

se_sum <- sqrt(vcov(gama.model)[2,2] + vcov(gama.model)[3,3] - 2 * vcov(gama.model)[2,3])
se_sum

# Calculate the t-statistic
t_statistic <- coef_sum / se_sum
t_statistic

# Calculate the p-value
p_value <- 2 * (1 - pt(abs(t_statistic), df = df.residual(gama.model)))
p_value

## Reject null hypothesis as it is less 

########################################
# 02
########################################

weld_data<-read.table("weld.txt", sep="\t", dec=".", header=TRUE)
weld_data
names(weld_data)
glimpse(weld_data)

gaussian.model <- glm(weld_data$Strength~ factor(Drying) + factor(Material), family=gaussian(link="identity"), data=weld_data)
gaussian.model

case1 <- data.frame(Drying = 0, Material = 0, Thickness = 0, Angle = 0, Opening = 0, Preheating = 0)
case2 <- data.frame(Drying = 0, Material = 1, Thickness = 0, Angle = 0, Opening = 0, Preheating = 0)


pred1 <- predict(gaussian.model, newdata = case1)
pred2 <- predict(gaussian.model, newdata = case2)
d_value <- pred2 - pred1
d_value

