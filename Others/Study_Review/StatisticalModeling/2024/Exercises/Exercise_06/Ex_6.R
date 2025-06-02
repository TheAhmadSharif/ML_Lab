# Read the data
data <- read.table("chromoabnormal.txt", sep="\t", dec=".", header=TRUE)

# Load required library
library(stats)

# Define the log-likelihood function for the Poisson model
log_likelihood <- function(params, data) {
  beta0 <- params[1]
  beta1 <- params[2]
  beta2 <- params[3]
  beta3 <- params[4]
  mu <- exp(beta0 + beta1 * data$doseamt + beta2 * data$doserate + beta3 * data$doseamt * data$doserate)
  log_lik <- sum(dpois(data$ca, mu, log = TRUE))
  return(-log_lik)
}

# Initial parameter values
initial_params <- c(0, 0, 0, 0)

# Fit the model using maximum likelihood estimation
fit <- optim(par = initial_params, fn = log_likelihood, data = data)

# Extract the estimated parameters
beta0_hat <- fit$par[1]
beta1_hat <- fit$par[2]
beta2_hat <- fit$par[3]
beta3_hat <- fit$par[4]

# Calculate the expected value of the ratio
x1_star <- 4
x2_star <- 0.75
mu_star <- exp(beta0_hat + beta1_hat * x1_star + beta2_hat * x2_star + beta3_hat * x1_star * x2_star)
t_star <- mean(data$cells) # Average number of cells
expected_ratio <- mu_star / t_star

# Print the result
cat("Maximum Likelihood Estimate for E(Zi) when x1* =", x1_star, "and x2* =", x2_star, "is:", expected_ratio, "\n")
