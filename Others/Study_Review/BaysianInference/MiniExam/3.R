# Data
install.packages("MCMCpack")

library(MCMCpack)
mpg <- c(21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7,
         32.4, 30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26.0, 30.4, 15.8, 19.7, 15.0, 21.4)
weight <- c(2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3.150, 3.440, 3.440, 4.070, 3.730, 3.780,
            5.250, 5.424, 5.345, 2.200, 1.615, 1.835, 2.465, 3.520, 3.435, 3.840, 3.845, 1.935, 2.140, 1.513,
            3.170, 2.770, 3.570, 2.780)
sixcyl <- c(1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
eightcyl <- c(0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0)

# Joint posterior sampling using MCMC


# Specify priors
prior_mean <- rep(0, 4)
prior_variance <- diag(10000, ncol = 4)



# Specify likelihood
likelihood <- function(beta, sigma) {
  ll <- sum(dnorm(mpg, beta[1] + beta[2] * weight + beta[3] * sixcyl + beta[4] * eightcyl, sigma, log = TRUE))
  return(ll)
}

# Specify posterior
posterior <- function(beta, sigma) {
  prior <- dmvnorm(beta, prior_mean, prior_variance)
  likelihood <- likelihood(beta, sigma)
  posterior <- prior + likelihood
  return(posterior)
}

posterior <- function(params) {
  # Define your posterior here
}

# Run MCMC sampling using metrop
mcmc_results <- metrop(posterior, data = NULL, n.iter = 10000, thin = 10, tune = TRUE, verbose = TRUE)

# a) Plotting marginal distributions
par(mfrow = c(2, 2))
hist(posterior_samples$X1, main = "Marginal Distribution of beta0", xlab = "beta0")
hist(posterior_samples$X2, main = "Marginal Distribution of beta1", xlab = "beta1")
hist(posterior_samples$X3, main = "Marginal Distribution of beta2", xlab = "beta2")
hist(posterior_samples$X4, main = "Marginal Distribution of beta3", xlab = "beta3")

# b) Compute 95% equal-tail probability intervals
compute_interval <- function(samples, ci = 0.95) {
  lower_bound = quantile(samples, (1 - ci) / 2)
  upper_bound = quantile(samples, 1 - (1 - ci) / 2)
  return(c(lower_bound, upper_bound))
}

# Compute intervals
beta0_interval = compute_interval(posterior_samples$X1)
beta1_interval = compute_interval(posterior_samples$X2)
beta2_interval = compute_interval(posterior_samples$X3)
beta3_interval = compute_interval(posterior_samples$X4)

# Print intervals
cat("95% Equal-Tail Probability Interval for beta0:", beta0_interval, "\n")
cat("95% Equal-Tail Probability Interval for beta1:", beta1_interval, "\n")
cat("95% Equal-Tail Probability Interval for beta2:", beta2_interval, "\n")
cat("95% Equal-Tail Probability Interval for beta3:", beta3_interval, "\n")

# c) Investigate if the effect on mpg is different in cars with six cylinders compared to cars with eight cylinders
effect_difference = posterior_samples$X3 - posterior_samples$X4

# Plot the distribution of the difference
hist(effect_difference, main = "Difference in Effect on mpg", xlab = "Difference")

# d) Estimate the predictive distribution for a new 4 cylinder car with weight = 3.5
weight_new <- 3.5
sixcyl_new <- 1
eightcyl_new <- 0

# Calculate the predicted mpg for the new car using posterior samples
predicted_mpg <- posterior_samples$X1 + posterior_samples$X2 * weight_new +
  posterior_samples$X3 * sixcyl_new + posterior_samples$X4 * eightcyl_new

# Plot the predictive distribution
hist(predicted_mpg, main = "Predictive Distribution of mpg for a New 4 Cylinder Car",
     xlab = "Predicted mpg")