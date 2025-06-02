# Load the data from the file
data <- read.table("galapagos.txt", sep="\t", dec=".", header=TRUE)

# Display the loaded data
print(data)

# Define the new values for the explanatory variables
x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

# Fit Poisson regression model
model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")

# Predict µi* for the new values of explanatory variables
mu_star <- exp(predict(model, newdata = x_new, type = "link"))

# Output the maximum likelihood estimate for µi*
print(mu_star) # 27.86135


#################################################################





# Load the data from the file
data <- read.table("galapagos.txt", sep="\t", dec=".", header=TRUE)

# Define the new values for the explanatory variables
x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

# Fit Poisson regression model
model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")

# Predict µi* for the new values of explanatory variables
mu_star <- exp(predict(model, newdata = x_new, type = "link"))

# Calculate the 95% confidence interval estimate for µi*
conf_interval <- exp(confint(model, level = 0.95))

# Output the confidence interval
print(conf_interval)

# Obtain the lower bound of the confidence interval
lower_bound <- conf_interval["Area", "2.5 %"]

# Output the lower bound of the confidence interval
print(lower_bound) # 0.9993687


############################################ c) 

# Load the data from the file
data <- read.table("galapagos.txt", sep="\t", dec=".", header=TRUE)

# Define the new values for the explanatory variables
x_new <- data.frame(
  Area = 58.27,
  Elevation = 198,
  Nearest = 1.1,
  Scruz = 88.3,
  Adjacent = 0.57
)

# Fit Poisson regression model
model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")

# Predict Yf for the new values of explanatory variables
pred <- predict(model, newdata = x_new, type = "response", se.fit = TRUE)

# Calculate the 80% prediction interval
pred_interval <- pred$fit + qnorm(c(0.1, 0.9)) * pred$se.fit

# Output the prediction interval
print(pred_interval) # print(pred_interval) [1] 25.89416 29.82854
############################## d)

# Fit the full model (H1)
model_full <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "poisson")

# Fit the reduced model (H0)
model_reduced <- glm(Species ~ Area, data = data, family = "poisson")

# Calculate the likelihood ratio test statistic
LR <- -2 * (logLik(model_full) - logLik(model_reduced))

# Output the test statistic
print(LR) # 'log Lik.' -1898.746 (df=6)


##################################### e) 

# Fit the Quasi-Poisson model
quasi_poisson_model <- glm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = "quasipoisson")

# Calculate the deviance of the model
deviance <- deviance(quasi_poisson_model)

# Calculate the degrees of freedom of the model
df <- df.residual(quasi_poisson_model)

# Calculate the scaled deviance
scaled_dev <- deviance / df

# Calculate the unbiased estimate for the dispersion parameter
phi_hat <- scaled_dev

# Output the estimate
print(phi_hat)

##################################### f)


# Fit the full model (H1) with square root link
model_full <- glm(sqrt(Species) ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = quasipoisson(link = "sqrt"))

# Fit the reduced model (H0) with square root link
model_reduced <- glm(sqrt(Species) ~ Area, data = data, family = quasipoisson(link = "sqrt"))

# Calculate the likelihood ratio test statistic
LR <- -2 * (logLik(model_full) - logLik(model_reduced))

# Output the test statistic
print(LR)



########### 2) 


data <- read.table("applejuiceCRA7152.txt", sep="\t", dec=".", header=TRUE)

# Fit the full model (H1) with square root link
model_full <- glm(sqrt(Species) ~ Area + Elevation + Nearest + Scruz + Adjacent, data = data, family = quasipoisson(link = "sqrt"))

# Check convergence of the full model
if (!is.null(model_full$dispersion) && model_full$iter < model_full$maxit) {
  # Fit the reduced model (H0) with square root link
  model_reduced <- glm(sqrt(Species) ~ Area, data = data, family = quasipoisson(link = "sqrt"))
  
  # Check convergence of the reduced model
  if (!is.null(model_reduced$dispersion) && model_reduced$iter < model_reduced$maxit) {
    # Calculate the likelihood ratio test statistic
    LR <- -2 * (logLik(model_full) - logLik(model_reduced))
    
    # Check for NA values in LR
    if (!is.na(LR)) {
      # Output the test statistic
      print(LR)
    } else {
      print("Likelihood ratio test statistic calculation failed.")
    }
  } else {
    print("Model fitting for the reduced model (H0) did not converge.")
  }
} else {
  print("Model fitting for the full model (H1) did not converge.")
}
#################### 2 ####################

# Load the data
data <- read.table("applejuiceCRA7152.txt", sep="\t", dec=".", header=TRUE)

# Define the variables
Y <- data$Growth
X1 <- 4.5
X2 <- 20
X3 <- 30
X4 <- 17

# Fit the logistic regression model
model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = binomial)

# Coefficients
beta0_hat <- coef(model)["(Intercept)"]
beta1_hat <- coef(model)["pH"]
beta2_hat <- coef(model)["Nisin"]
beta3_hat <- coef(model)["Temperature"]
beta4_hat <- coef(model)["Brix"]

# Calculate the expected value µi
logit_mu_i <- beta0_hat + beta1_hat*X1 + beta2_hat*X2 + beta3_hat*X3 + beta4_hat*X4
mu_i <- exp(logit_mu_i) / (1 + exp(logit_mu_i))

mu_i # 0.1118623
#################### b) 
#################### c) 

data <- read.table("applejuiceCRA7152.txt", sep="\t", dec=".", header=TRUE)


# Fit the restricted model H0
restricted_model <- glm(Growth ~ pH + Nisin, data = data, family = binomial)

# Fit the full model H1
full_model <- glm(Growth ~ pH + Nisin + Temperature + Brix, data = data, family = binomial)

# Obtain log-likelihood values for both models
log_likelihood_restricted <- logLik(restricted_model)
log_likelihood_full <- logLik(full_model)

# Calculate the test statistic
LR <- -2 * (log_likelihood_restricted - log_likelihood_full)
LR
#################### d) 
#################### e) 
#################### f) 