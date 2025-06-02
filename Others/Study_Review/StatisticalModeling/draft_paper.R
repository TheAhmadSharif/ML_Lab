setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")
############################ Exercise 3 > 1 > a ############################

Alba <- read.csv("Alba.txt", sep = "\t", dec = ".")
head(Alba)
attach(Alba)


model_identity_3_1_a <- glm(DryMatter ~ Dose * factor(Herbicide), family = gaussian(link = "identity"), data = Alba)
model_log_3_1_a <- glm(DryMatter ~ Dose * factor(Herbicide), family = gaussian(link = "log"),  data = Alba)
model_inverse_3_1_a <- glm(DryMatter ~ Dose * factor(Herbicide), family = gaussian(link = "inverse"), data = Alba)
model_mu_3_1_a <- model_mu2 <- glm(DryMatter ~ Dose * factor(Herbicide), family = gaussian(link="1/mu^2"), data = Alba)

MSE_identity_3_1_a <- mean(residuals(model_identity_3_1_a, type = "response")^2)
MSE_log_3_1_a <- mean(residuals(model_log_3_1_a, , type = "response")^2)
MSE_inverse_3_1_a <- mean(residuals(model_inverse_3_1_a, , type = "response")^2)
MSE_mu_3_1_a <- mean(residuals(model_mu_3_1_a, , type = "response")^2)


print(MSE_identity_3_1_a) # 0.9325439
print(MSE_log_3_1_a) #  0.2810279
print(MSE_inverse_3_1_a) # 0.2693486  ****
print(MSE_mu_3_1_a) # 0.3344594

############################ Exercise 3 > 1 > b ############################
head(Alba)


newdata <- data.frame(Dose = 50, Herbicide = "Glyphosate")
pred_3_1_b <- predict(model_inverse_3_1_a, newdata = newdata, type = "response")
pred_3_1_b # 2.617399
############################ Exercise 3 > 1 > c  ############################

newdata <- data.frame(Dose = 50, Herbicide = "Glyphosate")
pred_3_1_c <- predict(model_inverse_3_1_a, newdata = newdata, type = "link", se.fit = TRUE)
pred_3_1_c # 0.3820587

lower <- pred_3_1_c$fit - 1.96 *  pred_3_1_c$se.fit
lower # 0.3441482 
############################ Exercise 3 > 1 > d  ############################


