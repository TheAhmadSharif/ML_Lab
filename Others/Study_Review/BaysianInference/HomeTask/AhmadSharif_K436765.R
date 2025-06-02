# Data
X1 <- c(22, 35, 36, 29, 9, 40, 11, 195, 174, 33, 22, 101, 58, 16, 100, 65, 19, 51)
N1 <- c(258, 294, 280, 328, 275, 423, 385, 489, 522, 401, 422, 647, 617, 426, 599, 530, 462, 621)

X0 <- c(24, 11, 25, 18, 1, 26, 5, 125, 94, 19, 4, 108, 41, 13, 63, 47, 17, 41)
N0 <- c(129, 81, 135, 162, 94, 275, 208, 410, 396, 175, 229, 545, 417, 140, 384, 304, 236, 395)

# Prior parameters
alpha <- 0.1
beta <- 0.1

# Function to calculate the posterior distribution
calculate_posterior <- function(X, N, alpha, beta) {
  alpha_post <- alpha + sum(X)
  beta_post <- beta + sum(N)
  return(rgamma(100000, shape = alpha_post, rate = beta_post))
}

# Calculate the posterior distributions
posterior_host <- calculate_posterior(X1, N1, alpha, beta)
posterior_previous <- calculate_posterior(X0, N0, alpha, beta)


par(mar = c(4, 4, 2, 2))

# Plot the posterior distribution of λ1 (Host Year)
hist(posterior_host, main = "Posterior Distribution of λ1 (Host Year)",
     xlab = "λ1 (Expected Medals per Participant)", col = "lightblue", border = "black")

# Reset plot margins to default values
par(mar = c(5, 4, 4, 2) + 0.1)


###################################


monte_carlo_simulation <- function(X1, N1, X0, N0, alpha, beta, num_samples) {
  posterior_host <- calculate_posterior(X1, N1, alpha, beta)
  posterior_previous <- calculate_posterior(X0, N0, alpha, beta)
  
  samples_host <- rgamma(num_samples, shape = alpha + sum(X1), rate = beta + sum(N1))
  samples_previous <- rgamma(num_samples, shape = alpha + sum(X0), rate = beta + sum(N0))
  
  posterior_probability <- mean(samples_host > samples_previous)
  
  return(posterior_probability)
}

# Perform Monte Carlo simulation for different sets of hyper-prior parameters
hyper_prior_sets <- list(c(0.1, 0.1), c(1, 1), c(0.5, 0.5), c(2, 2))

for (hyper_prior_set in hyper_prior_sets) {
  alpha <- hyper_prior_set[1]
  beta <- hyper_prior_set[2]
  
  posterior_probability <- monte_carlo_simulation(X1, N1, X0, N0, alpha, beta, 100000)
  
  cat(sprintf("Posterior probability (λ1 > λ0) with hyper-prior parameters %.1f, %.1f: %.4f\n", alpha, beta, posterior_probability))
}

# Posterior probability (λ1 > λ0) with hyper-prior parameters 0.1, 0.1: 0.0053
# Posterior probability (λ1 > λ0) with hyper-prior parameters 1.0, 1.0: 0.0050
# Posterior probability (λ1 > λ0) with hyper-prior parameters 0.5, 0.5: 0.0051
# Posterior probability (λ1 > λ0) with hyper-prior parameters 2.0, 2.0: 0.0044



