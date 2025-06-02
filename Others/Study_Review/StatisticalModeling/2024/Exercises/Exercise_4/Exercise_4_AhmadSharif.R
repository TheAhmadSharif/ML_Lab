### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 04

setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")



# Load the data
data <- read.table("ozone.txt", sep="\t", dec=".", header=TRUE)

data
# Fit models
model_identity <- lm(ozone ~ rad + temp + wind, data=data)
model_log <- lm(log(ozone) ~ rad + temp + wind, data=data)
model_inverse <- lm(1/ozone ~ rad + temp + wind, data=data)
model_exponential <- lm(log(ozone) ~ log(rad) + log(temp) + log(wind), data=data)

# Calculate AIC values
AIC_identity <- AIC(model_identity)
AIC_log <- AIC(model_log)
AIC_inverse <- AIC(model_inverse)
AIC_exponential <- AIC(model_exponential)


##################### b ##################### 


# Fit linear models for Pearson residuals for normal, Gamma, and Inverse Gaussian distributions
model_normal <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_gamma <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_inverse_gaussian <- lm(resid(model_identity)^2 ~ I(1/fitted(model_identity)))

# Test the null hypothesis H0: α1 = 0 for eadata:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAbElEQVR4Xs2RQQrAMAgEfZgf7W9LAguybljJpR3wEse5JOL3ZObDb4x1loDhHbBOFU6i2Ddnw2KNiXcdAXygJlwE8OFVBHDgKrLgSInN4WMe9iXiqIVsTMjH7z/GhNTEibOxQswcYIWYOR/zAjBJfiXh3jZ6AAAAAElFTkSuQmCCch distribution
test_normal <- summary(model_normal)$coefficients["fitted(model_identity)", "Pr(>|t|)"]
test_gamma <- summary(model_gamma)$coefficients["fitted(model_identity)", "Pr(>|t|)"]
test_inverse_gaussian <- summary(model_inverse_gaussian)$coefficients["I(1/fitted(model_identity))", "Pr(>|t|)"]

test_normal
test_gamma
test_inverse_gaussian
##################### c ##################### 


model <- lm(log(ozone) ~ rad + temp + wind, data=data)
beta3 <- coef(model)["wind"]
var_beta3 <- vcov(model)["wind", "wind"]
W <- (beta3^2) / var_beta3

print(W)

##################### d ##################### 

# Fit the full model
full_model <- lm(log(ozone) ~ rad + temp + wind, data=data)

# Fit the reduced model
reduced_model <- lm(log(ozone) ~ rad, data=data)

# Get the sum of squared errors for the full model
SSE_full <- sum(resid(full_model)^2)

# Get the sum of squared errors for the reduced model
SSE_reduced <- sum(resid(reduced_model)^2)

p <- length(full_model$coefficients)

q <- length(reduced_model$coefficients)
n <- nrow(data)
F <- ((SSE_reduced - SSE_full) / (p - q)) * ((n - p) / SSE_full)

print(F) # 72.7952

########################## 2 a) ######################

# Load the dataset
data <- read.table("denim.txt", sep = "\t", dec = ".", header = TRUE)

# Fit the models
model1_identity <- lm(Abrasion ~ Denim, data = data)
model12_identity <- lm(Abrasion ~ Denim + Laundry, data = data)
model1_log <- lm(log(Abrasion) ~ Denim, data = data)
model12_log <- lm(log(Abrasion) ~ Denim + Laundry, data = data)
model1_inverse <- lm(1/Abrasion ~ Denim, data = data)
model12_inverse <- lm(1/Abrasion ~ Denim + Laundry, data = data)

# Calculate AIC for each model
AIC_values <- c(AIC(model1_identity), AIC(model12_identity), AIC(model1_log),
                AIC(model12_log), AIC(model1_inverse), AIC(model12_inverse))

# Print AIC values for each model
AIC_values


################### 2) b) ########################


# Fit linear models for Pearson residuals for normal, Gamma, and Inverse Gaussian distributions
model_normal <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_gamma <- lm(resid(model_identity)^2 ~ fitted(model_identity))
model_inverse_gaussian <- lm(resid(model_identity)^2 ~ fitted(model_identity))

# Compute AIC values
AIC_normal <- AIC(model_normal)
AIC_gamma <- AIC(model_gamma)
AIC_inverse_gaussian <- AIC(model_inverse_gaussian)


################### 2) c) ########################


model_normal <- lm(ozone ~ rad + temp + wind, data=data)

x1f1 <- 0
x1f2 <- 1
x2f1 <- 25
x2f2 <- 3

Y1f <- predict(model_normal, newdata = data.frame(rad = x1f1, temp = x1f2, wind = x1f2))

Y2f <- predict(model_normal, newdata = data.frame(rad = x2f1, temp = x2f2, wind = x2f2))

d_value <- (Y2f - Y1f) / sd(residuals(model_normal))

# Print the d-value
print(d_value) ## -0.08992886 

################### 2) d) ########################


model_normal <- lm(ozone ~ rad + temp + wind, data=data)

summary_model <- summary(model_normal)

coefficients <- coef(summary_model)
b_X2_denim <- coefficients["temp", 1]  # Coefficient estimate for X2 = Denim
se_b_X2_denim <- coefficients["temp", 2]  # Standard error for the coefficient of X2 = Denim

t_stat_X2_denim <- b_X2_denim / se_b_X2_denim

p_value_X2_denim <- 2 * pt(-abs(t_stat_X2_denim), df = nrow(data) - ncol(data$coefficients))

# Print the t-test statistic for X2 = Denim
print(t_stat_X2_denim) ## 6.515877

################### 3) a) ########################

beta_hat <- c(1, 0.5)
phi_hat <- 0.05

X <- matrix(c(rep(1, 3), rep(1, 3), rep(1, 3), log(c(3, 6, 9))), ncol = 2, byrow = TRUE)

W <- diag(1 / phi_hat, nrow(X))

H <- t(X) %*% W %*% X
H_inv <- solve(H)

covariance_matrix <- H_inv
print(covariance_matrix)
