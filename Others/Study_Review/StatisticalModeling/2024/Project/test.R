# Parameters for intercept-only model
beta_0_hat <- 1    # replace with your estimated beta_0
sigma2_hat <- 0.1  # replace with your estimated variance of residuals
n <- 10            # replace with the number of observations in your dataset
alpha <- 0.05      # significance level

# Degrees of freedom: number of observations minus the number of parameters
df <- n - 1

# Critical t value for the (1-alpha/2) quantile
t_alpha_2 <- qt(1 - alpha/2, df)

# Design matrix X (vector of ones for intercept-only model)
X <- matrix(rep(1, n), ncol = 1)

# Calculation of (X'X)^-1
XX_inv <- solve(t(X) %*% X)

# Since x_f is just a 1 for the new observation in this model
x_f <- matrix(1, nrow = 1)

# Prediction interval calculation
lower_bound <- beta_0_hat - t_alpha_2 * sqrt(sigma2_hat * (1 + t(x_f) %*% XX_inv %*% x_f))
upper_bound <- beta_0_hat + t_alpha_2 * sqrt(sigma2_hat * (1 + t(x_f) %*% XX_inv %*% x_f))

# Display the prediction interval
cat("The 100(1 - alpha)% prediction interval for Y_f is: [", lower_bound, ",", upper_bound, "]\n")
#######################################################


# Given values for a model with one predictor
beta_hat <- c(1.5, 0.8) # Estimated coefficients (intercept and slope)
sigma_hat <- 0.2         # Estimated standard deviation
x <- 1:10                # The predictor variable
X <- cbind(1, x)         # Design matrix X including the intercept

# New observation's predictor value
x_new <- c(1, 11)        # Including the intercept

# Calculate the mean of the prediction for the new observation
mu_pred_new <- sum(x_new * beta_hat)

# Calculate the variance of the prediction for the new observation
var_pred_new <- sigma_hat^2 * (1 + t(x_new) %*% solve(t(X) %*% X) %*% x_new)

# Degrees of freedom
df <- nrow(X) - ncol(X)

# Calculate the t-value for the given alpha level
t_value <- qt(1 - alpha/2, df)

# Calculate the prediction interval for the new observation
lower_bound <- mu_pred_new - t_value * sqrt(var_pred_new)
upper_bound <- mu_pred_new + t_value * sqrt(var_pred_new)

# Print the prediction interval
print(c(lower_bound, upper_bound))
###############


