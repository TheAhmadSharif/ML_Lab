setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")



# Load the data
data <- read.table("ozone.txt", sep="\t", dec=".", header=TRUE)

# Fit linear models for Pearson residuals for normal, Gamma, and Inverse Gaussian distributions
model_normal <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_gamma <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_inverse_gaussian <- lm(resid(model_identity)^2 ~ I(1/fitted(model_identity)))

# Test the null hypothesis H0: α1 = 0 for eadata:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAbElEQVR4Xs2RQQrAMAgEfZgf7W9LAguybljJpR3wEse5JOL3ZObDb4x1loDhHbBOFU6i2Ddnw2KNiXcdAXygJlwE8OFVBHDgKrLgSInN4WMe9iXiqIVsTMjH7z/GhNTEibOxQswcYIWYOR/zAjBJfiXh3jZ6AAAAAElFTkSuQmCCch distribution
test_normal <- summary(model_normal)$coefficients["fitted(model_identity)", "Pr(>|t|)"]
test_gamma <- summary(model_gamma)$coefficients["fitted(model_identity)", "Pr(>|t|)"]
test_inverse_gaussian <- summary(model_inverse_gaussian)$coefficients["I(1/fitted(model_identity))", "Pr(>|t|)"]

# Compare p-values from hypothesis tests
if (test_normal < 0.05) {
  print("For normal distribution, reject null hypothesis H0: α1 = 0")
} else {
  print("For normal distribution, do not reject null hypothesis H0: α1 = 0")
}

if (test_gamma < 0.05) {
  print("For Gamma distribution, reject null hypothesis H0: α1 = 0")
} else {
  print("For Gamma distribution, do not reject null hypothesis H0: α1 = 0")
}

if (test_inverse_gaussian < 0.05) {
  print("For Inverse Gaussian distribution, reject null hypothesis H0: α1 = 0")
} else {
  print("For Inverse Gaussian distribution, do not reject null hypothesis H0: α1 = 0")
}


# Fit the Gamma regression model
model_gamma <- glm(Y ~ X1 + X2 + X3, family = Gamma(link = "log"))

# Extract the estimated coefficient and standard error for the variable X3 = wind
beta3 <- coef(model_gamma)["X3"]
se_beta3 <- summary(model_gamma)$coef["X3", "Std. Error"]

# Calculate the Wald test statistic
Wald_statistic <- (beta3 / se_beta3)^2
Wald_statistic



###################
Y = data["ozone"]
X1 = data["rad"]
X2 = data["temp"]
X3 = data["wind"]


# Fit the Gamma regression model
model_gamma <- glm(Y ~ X1 + X2 + X3, family = Gamma(link = "log"))

# Extract the estimated coefficients for the variables X2 and X3
beta2 <- coef(model_gamma)["X2"]
beta3 <- coef(model_gamma)["X3"]

# Extract the covariance between beta2 and beta3
cov_beta2_beta3 <- vcov(model_gamma)[c("X2", "X3"), c("X2", "X3")]

# Calculate the Wald test statistic
Wald_statistic <- ((beta2 + beta3) / sqrt(cov_beta2_beta3))^2
Wald_statistic











# Fit the chosen model (Midentity) from part (a)
model_identity <- lm(ozone ~ rad + temp + wind, data=data)

# Compute Pearson's residuals
residuals_identity <- residuals(model_identity)

# Fit linear model for Pearson's residuals under different distributional assumptions
# Normal distribution
lm_normal <- lm(residuals_identity^2 ~ predict(model_identity) + 0)
summary(lm_normal)  # Test for H0: α1 = 0

# Gamma distribution
library(MASS)
fit_gamma <- fitdistr(residuals_identity^2, "gamma")
shape <- fit_gamma$estimate[1]
rate <- 1/fit_gamma$estimate[2]
lm_gamma <- lm(residuals_identity^2 ~ predict(model_identity) + 0)
summary(lm_gamma)  # Test for H0: α1 = 0

# Inverse Gaussian distribution
fit_invgauss <- fitdistr(residuals_identity^2, "inverse.gaussian")
lambda <- fit_invgauss$estimate[1]
mu <- fit_invgauss$estimate[2]
lm_invgauss <- lm(residuals_identity^2 ~ predict(model_identity) + 0)
summary(lm_invgauss)  # Test for H0: α1 = 0


