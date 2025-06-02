### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 05
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
library(nnet)

install.packages("maxLik")
library(maxLik)

data<-read.table("retinopathy.txt", header=TRUE, sep="\t", dec=".")
data 

names(data)
labels(data)

attach(data)

RET <- data$RET
RET

SM <- data$SM
SM

DIAB <- data$DIAB
DIAB

GH <- data$GH
GH

BP <- data$BP
BP

Y <- RET
X1 <- DIAB
X2 <- GH
X3 <- BP
X4 <- SM



newdata <- data.frame(X1 = 20)
newdata



df <- data
model <- multinom(factor(RET) ~ X1 + X2 + X3 + X4, data = data)

model

# create a new data frame with xi*1 = 20
newdata <- data.frame(DIAB = 20, GH = mean(df$GH), BP = mean(df$BP), SM = mean(df$SM))
newdata

pred_probs <- predict(model, newdata, type = "probs")
pred_probs





# Subset the data to keep only observations with xi1 = 20
data_subset <- subset(data, DIAB == 20)

# Create indicator variables for the different levels of Y
Y1 <- ifelse(data_subset$RET == 0, 1, 0)
Y2 <- ifelse(data_subset$RET == 1, 1, 0)
Y3 <- ifelse(data_subset$RET == 2, 1, 0)

# Fit the multinomial logit model
fit <- multinom(RET ~ DIAB + GH + BP + SM, data = data)

# Get the estimated coefficients
beta <- coef(fit)

beta

# Calculate the predicted probabilities for each observation
pred_probs <- predict(fit, newdata = data_subset, type = "probs")

# Calculate the maximum likelihood estimate for P(Yi* = "2")
logLik <- log(pred_probs[2])
logLik



##############################################
data_sub <- subset(data, DIAB == 20)

# Fit the cumulative proportional odds logit model
install.packages("MASS")
library(MASS)
model <- polr(factor(RET) ~ DIAB, data = data, Hess = TRUE)

# Calculate the predicted probabilities for each level of RET
pred_probs <- predict(model, newdata = data_sub, type = "probs")

# Extract the probability of RET = 2 (advanced retinopathy or blind)
prob_ret2 <- pred_probs[0, 1]



######################

# 2) 

# Load data
data <- read.table("NitrogenYield.txt", header=TRUE)

attach(data)

data
names(data)
# Fit second degree polynomial model
model <- lm(Yield ~ Nitrogen + I(Nitrogen^2), data=data)

# Get maximum likelihood estimate for beta2
beta2 <- coef(model)[3]
beta2

# b)

fit <- lm(log(Yield) ~ Nitrogen, data = data)
summary(fit)


xi_star <- 150
beta0 <- 4.73230
beta1 <- 0.01293
mu_star <- exp(beta0 + beta1 * xi_star)
mu_star




# e) 

data <- data.frame(Nitrogen = c(10, 10, 10, 20, 20, 20, 30, 30, 30, 40, 40, 40, 50, 50, 50, 60, 60, 60, 70, 70, 70, 80, 80, 80, 90, 90, 90, 100, 100, 100, 110, 110, 110, 120, 120, 120, 130, 130, 130, 140, 140, 140, 150, 150, 150, 160, 160, 160, 170, 170, 170, 180, 180, 180, 190, 190, 190, 200, 200, 200),
                   Yield = c(28.08, 30.92, 30.71, 37.86, 39.78, 45.04, 41.87, 41.3, 52.6, 58.6, 64.87, 61.2, 47.75, 52.55, 59.43, 55.92, 75.96, 60.77, 72.98, 70.8, 74, 68.9, 72.47, 67.23, 77.49, 79.85, 83.03, 82.51, 87.54, 71.49, 85.37, 76.36, 80.52, 94.27, 77.72, 88.08, 87.19, 88.87, 89.85, 94.65, 95.57, 94.95, 90.86, 104.16, 90.38, 86.02, 89.4, 98.66, 102.09, 95.72, 89.32, 91.1, 95.72, 97.63, 91.54, 101.19, 86.08, 82.52, 105.55, 92.17))

# fit the asymptotic regression model
model <- nls(Yield ~ SSasymp(Nitrogen, Asym, R0, lrc),
             data = data,
             start = list(Asym = max(data$Yield),
                          R0 = min(data$Yield),
                          lrc = log((max(data$Yield) - min(data$Yield)) / (max(data$N) - min(data$N)))))

# predict the response for xf = 150
xf <- 150
yf_pred <- predict(model, newdata = data.frame(Nitrogen = xf))

# calculate the standard error of the predicted response
yf_se <- summary(model)$sigma * sqrt(1 + (1 / length(data$Nitrogen)) + ((xf - mean(data$Nitrogen))^2 / sum((data$Nitrogen - mean(data$Nitrogen))^2)))
yf_se

x1 <- rnorm(12, mean = 78.68, sd=10.543)
x2 <- rnorm(12, mean = 87.67, sd=8.139)
x1_mean <- 78.67
x2_mean <- 87.67

s1 <- 10.543
s2 <- 8.139

n1 <- 12
n2 <- 12

g_obs <- (x1_mean - x2_mean) / (sqrt(((n1-1)*s1^2 + (n2-1)*s2^2) / (n1+n2-2)) * sqrt(1/n1 + 1/n2))
g_obs
