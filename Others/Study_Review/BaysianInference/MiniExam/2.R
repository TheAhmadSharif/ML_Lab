# Install and load required packages
install.packages("rstan")
library(rstan)


differences <- c(-9, -4, -21, -3, -20, -31, -17, -26, -26, -10, -23, -33, -19, -19, -23)


stan_code <- "
data {
  int<lower=0> N;          // Number of observations
  real differences[N];     // Observed differences
}

parameters {
  real<lower=0> psi;        // Precision parameter
  real mu;                  // Mean parameter
}

model {
  // Priors
  psi ~ gamma(0.35, 1.01);
  mu ~ normal(0, sqrt(1 / (0.003 * psi)));

  // Likelihood
  differences ~ normal(mu, sqrt(1 / psi));
}
"


stan_model <- stan_model(model_code = stan_code)


stan_data <- list(N = length(differences), differences = differences)

# Run MCMC sampling
stan_samples <- sampling(stan_model, data = stan_data, iter = 2000, chains = 4, warmup = 1000)

# Extract posterior samples
posterior_samples_psi <- extract(stan_samples)$psi
posterior_samples_mu <- extract(stan_samples)$mu

# a) Marginal posterior distribution of ψ
posterior_samples_psi

# b) Marginal posterior distribution of µ
posterior_samples_mu

# c) Marginal posterior 95% HPD interval for µ
hpd_interval_mu <- quantile(posterior_samples_mu, c(0.025, 0.975))
cat("Marginal posterior 95% HPD interval for µ:", hpd_interval_mu, "\n")

# d) Comment on the effect of the drug
# You can examine the mean and the HPD interval of µ to make conclusions about the effect of the drug.

# Print the results
print(summary(stan_samples))