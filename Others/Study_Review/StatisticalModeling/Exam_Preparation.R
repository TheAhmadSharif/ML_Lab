setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")


############################ Exercise 3 > 1 > D ############################
# a) Midentity : µi = β0 + β1 xi1 + αj + γj xi1 ,
Alba <- read.csv("Alba.txt", header = TRUE, sep = "\t")
attach(Alba)
head(Alba)

model_inverse <- glm( DryMatter ~ Dose * factor(Herbicide), data = Alba, family = gaussian(link="inverse"))
model_inverse

MSE_1 <- mean(residuals(model_inverse, type="response")^2)
MSE_1 # 0.2693486


# b) ############################ Exercise 3 > 1 > b ############################

newdata <- data.frame(Dose = 50, Herbicide = "Glyphosate")
pred <- predict(model_inverse, newdata = newdata, type="response")
pred # 2.617399 

# c) ############################ Exercise 3 > 1 > c ############################
predict_c <- predict(model_inverse, newdata = newdata, type = "link", se.fit = TRUE)
predict_c # 0.3820587 
lower_bound <- predict_c$fit - 1.96 * predict_c$se.fit
print(lower_bound[1])
# qnorm(0.025, lower.tail = FALSE) # 1.96
# qnorm(0.1, lower.tail = FALSE) # 1.96


# d) ############################ Exercise 3 > 1 > d ############################ 
model.matrix(model_inverse)
x <- t(t(c(1, 50, 1, 50)))
x
fhai <- summary(model_inverse)$dispersion
fhai # 0.2861666


DF <--(pred^2)
DF # -6.850775 
variance_effect <- fhai + (DF)^2 * t(x)  %*% vcov(model_inverse)  %*% x

lower_bound <- pred - qnorm(.9) * sqrt(variance_effect)
lower_bound # 1.911119

#############################################################################
#############################################################################

############################ Exercise 3 > 2 > A ############################


data <- read.csv("ratstime.txt", header = TRUE, sep = "\t")
attach(data)
head(data)

model_identity <- glm(time ~ poison + treat, family = gaussian(link="identity"), data = data)
model_log <- glm(time ~ poison + treat, family = gaussian(link="log"), data = data)
model_inverse <- glm(time ~ poison + treat, family = gaussian(link="inverse"), data = data)

MSE_1 <- mean(residuals(model_identity)^2)
MSE_2 <- mean(residuals(model_log)^2)
MSE_3 <- mean(residuals(model_inverse)^2)

MSE_1 # 0.02189297
MSE_2 # 0.0187694
MSE_3 # 0.01866069 ***

interaction.plot(poison,treat, fitted(model_identity))
interaction.plot(poison,treat, fitted(model_log))
interaction.plot(poison,treat, fitted(model_inverse))


############################ Exercise 3 > 2 > B ############################


model_log <- glm(time ~ poison + treat, family = gaussian(link="log"), data = data)
newdata <- data.frame(poison = "II", treat = "B")

pred <- predict(model_log, newdata = newdata, type="link", se.fit =TRUE)
lower <- pred$fit - 1.96 * pred$se.fit
exp(lower) # 0.6847237 Becuase its log model family


# d) ###############

newdata <- data.frame(poison = "II", treat = "B")
pred <- predict(model_inverse, newdata = newdata, type="link", se.fit =TRUE)
pred
pred <- pred$fit - qnorm(.9) * pred$se.fit
pred
mu <- 1/pred
mu # 0.9033017 # Correct is 1.911119
highter_mu #  3.3236








############################################################################
############################ Exercise 3 > 2 > A ############################
# a) Midentity : µi = β0 + β1 xi1 + αj + γj xi1 ,
ratstime <- read.csv("ratstime.txt", header = TRUE, sep = "\t")
attach(ratstime)
head(ratstime)


model_identity <- glm(time ~ poison + treat, data = ratstime, family = gaussian(link = "identity"))
model_log <- glm(time ~ poison + treat, data = ratstime, family = gaussian(link = "log"))
model_inverse <- glm(time ~ poison + treat, data = ratstime, family = gaussian(link = "inverse"))

MSE_3_2_identity = mean(residuals(model_identity)^2)
MSE_3_2_log = mean(residuals(model_log)^2)
MSE_3_2_inverse = mean(residuals(model_inverse)^2)

print(MSE_3_2_identity) # 0.02189297
print(MSE_3_2_log) # 0.0187694
print(MSE_3_2_inverse) # 0.01866069 *** Best


############################ Exercise 3 > 2 > B ############################
# III
############################ Exercise 3 > 2 > C ############################

newdata <- data.frame(poison = "II", treat = "B")
pred_3_2_c <- predict(model_log, newdata = newdata, type = "link", se.fit = TRUE)
pred_3_2_c
lower_bound <- pred_3_2_c$fit - qnorm(0.975) * pred_3_2_c$se.fit
lower_bound # -0.3787372 

fhai <- summary(model_log)$dispersion
fhai # 0.0214508
l <- exp(lower_bound) # Becuase of log
l # 0.6847237 

############################ Exercise 3 > 2 > d ############################
model.matrix(model_log)

newdata <- data.frame(poison = "II", treat = "B")
pred_3_2_d<-predict(model_log, newdata=newdata, type="response")

fhai <- summary(model_log)$dispersion
DF <- pred_3_2_c
print(DF) # -0.0004601368
pred_3_2_d # 0.7952473
var_Yf <- (fhai) * (pred_3_2_d^2)

x <- t(t(c(1, 1, 0, 1, 0, 0)))

variance_effect <- var_Yf + (DF) ^2  * t(x) %*% vcov(model_log) %*% x
print(variance_effect) # 0.0214508

lower_bound <- pred_3_2_d - qnorm(0.9) * sqrt(variance_effect)
print(lower_bound) # 0.6075501