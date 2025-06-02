### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 05

setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")
str(data)

########################################## a) 

# Load the data
data <- read.table("galapagos.txt", sep="\t", dec=".", header=TRUE)
data


x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

# Fit Poisson regression model
model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")
mu_star <- exp(predict(model, newdata = x_new, type = "link"))

# Output the maximum likelihood estimate for µi*
print(mu_star) # 27.86135 




##################################### b) 


x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")
mu_star <- exp(predict(model, newdata = x_new, type = "link"))

conf_interval <- exp(confint(model, level = 0.95))
print(conf_interval)

lower_bound <- conf_interval["Area", "2.5 %"]
print(lower_bound) # 0.9993687


##################################### c) 

x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")
Yf <- predict(model, newdata = x_new, type = "response")
prediction_interval <- predict(model, newdata = x_new, interval = "prediction", level = 0.80)
print(prediction_interval)



##################################### d) 

full_model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")
null_model <- glm(Species ~ Area, data = data, family = "poisson")

likelihood_full <- logLik(full_model)
likelihood_null <- logLik(null_model)

test_statistic <- -2 * (likelihood_full - likelihood_null)

# Output the test statistic
print(test_statistic) # 'log Lik.' -1898.746 (df=6)

##################################### e) 
# Fit Quasi-Poisson model
quasi_poisson_model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "quasipoisson")

# Calculate residual deviance
residual_deviance <- quasi_poisson_model$deviance

# Calculate degrees of freedom
df <- df.residual(quasi_poisson_model)

# Calculate unbiased estimate of dispersion parameter
phi_hat <- residual_deviance / df

# Output the estimate
print(phi_hat) # 29.86857




##################################### f) 


# Fit full model
full_model <- glm(sqrt(Species) ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = quasipoisson(link = "sqrt"))

# Fit null model
null_model <- glm(sqrt(Species) ~ Area, data = data, family = quasipoisson(link = "sqrt"))

# Calculate likelihoods
likelihood_full <- logLik(full_model)
likelihood_null <- logLik(null_model)



##################################### 2  ##################################### 



##################################### a) 
# Read the data
data <- read.table("applejuiceCRA7152.txt", sep="\t", dec=".", header=TRUE)

# Display the data
print(data)

# Fit logistic regression model
model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = "binomial")

# Summary of the model
summary(model)

# Specified values of the explanatory variables
X_values <- c(pH = 4.5, Nisin = 20, Temperature = 30, Brix = 17)

# Coefficients from the logistic regression model
coefficients <- coef(model)

# Calculate the linear predictor (logit) using the specified values and coefficients
linear_predictor <- coefficients[1] + 
  coefficients[2] * X_values["pH"] +
  coefficients[3] * X_values["Nisin"] +
  coefficients[4] * X_values["Temperature"] +
  coefficients[5] * X_values["Brix"]

# Calculate the maximum likelihood estimate for the expected value mu_i
mu_estimate <- exp(linear_predictor) / (1 + exp(linear_predictor))

# Output the maximum likelihood estimate
print(mu_estimate) # 0.1118623

##################################### b) 



model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = binomial)
new_data <- data.frame(pH = 4.5, Nisin = 20, Temperature = 30, Brix = 17)
predicted_value <- predict(model, newdata = new_data, type = "response", interval = "confidence", level = 0.95)
print(predicted_value) # 0.1118623 



##################################### c) 
null_model <- glm(Growth ~ pH + Nisin, data = data, family = binomial)
alternative_model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = binomial)

log_likelihood_null <- logLik(null_model)
log_likelihood_alternative <- logLik(alternative_model)

LRT <- -2 * (log_likelihood_null - log_likelihood_alternative)

print(LRT) # 11.71865 (df=3)

##################################### d) 
# i. Logit link g(µi ) = logit(µi ),
