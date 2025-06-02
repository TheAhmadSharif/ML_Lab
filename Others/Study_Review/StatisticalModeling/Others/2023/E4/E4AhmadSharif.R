### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 04
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
if(!require(nortest)){
  install.packages("nortest")
  library(nortest)
}
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

data<-read.table("chromoabnormal.txt", header=TRUE, sep="\t", dec=".")
data 

names(data)
labels(data)

attach(data)


cells <- data$cells
ca <- data$ca
doseamt <- data$doseamt
doserate <- data$doserate

model <- glm(ca ~ doseamt + doserate, data = data, family = poisson())
summary(model)


# View the estimated coefficients
coef(model)


# Make a prediction for doseamt = 2.5 and doserate = 1.0
doseamt <- 2.5
doserate <- 1.0
predictor <- coef(model)[1] + coef(model)[2]*doseamt + coef(model)[3]*doserate
mu <- exp(predictor)
mu


# b) 

cells <- data$cells
ca <- data$ca
doseamt <- data$doseamt
doserate <- data$doserate

x1 <- doserate
x2 <- doserate

X <- data.frame(x1, x2)
X


# Model fitting


Y <- ca
t <- cells
Z <- Y/t
Z
fit <- glm(Y/t ~ x1 + x2 + x1*x2, family = poisson, data = X)
summary(fit)

# Maximum likelihood prediction for Yf/tf
xf1 <- 4
xf2 <- 0.75
tf <- 64070
Yf <- predict(fit, newdata = data.frame(x1 = xf1, x2 = xf2, tf = tf), type = "response")


# Prediction intervals for Yf/tf
PI <- predict(fit, newdata = data.frame(x1 = xf1, x2 = xf2, tf = tf), type = "link", se.fit = TRUE)
se <- PI$se.fit
z <- qnorm(0.975)
lower <- exp(PI$fit + z*se)
upper <- exp(PI$fit - z*se)

# Output
cat("Maximum likelihood prediction for Yf/tf:", Yf, "\n")
cat("Prediction interval for Yf/tf:", lower, "-", upper, "\n")


# c) 

# Fit full model
model.full <- glm(Y ~ x1 + x2 + x1*x2, family = poisson, data = data)
model.full
summary(model.full)
# Fit reduced model
model.reduced <- glm(Y ~ x1 + x1*x2, family = poisson, data = data)
model.reduced
summary(model.reduced)

# Calculate log-likelihood values
ll.full <- logLik(model.full)
ll.reduced <- logLik(model.reduced)

# Calculate test statistic
LR <- -2 * (ll.reduced - ll.full)

# Calculate p-value
pval <- pchisq(LR, df = 1, lower.tail = FALSE)

# Compare test statistic to critical value
if (LR > 3.84) {
  cat("X2 is a statistically significant predictor of Y (p =", pval, ")\n")
} else {
  cat("X2 is not a statistically significant predictor of Y (p =", pval, ")\n")
}


###############

# 2) 


data<-read.table("applejuiceCRA7152.txt", header=TRUE, sep="\t", dec=".")
data 


labels(data)
attach(data)
pH <- data$pH
Nisin <- data$Nisin
Temperature <- data$Temperature
Brix <- data$Brix
Growth <- data$Growth


# Fit logistic regression model with logit link function
model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = binomial(link = "logit"))
summary(model)
# Predict the expected value using new values for the explanatory variables
new_data <- data.frame(pH = 4.5, Nisin = 20, Temperature = 30, Brix = 17)
print(new_data)
expected_value <- predict(model, newdata = new_data, type = "response")
print(expected_value)


# c) 

# Define the new data point
newdata <- data.frame(pH = 4.5, Nisin = 20, Temperature = 30, Brix = 17)

# Calculate the 95% confidence interval
pred <- predict(model, newdata, interval = "confidence", level = 0.95)
pred
