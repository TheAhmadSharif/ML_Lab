### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 06

setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")

########################################## a) 

# Load the data
data <- read.table("chromoabnormal.txt", sep="\t", dec=".", header=TRUE)
data
library(stats)

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

fit <- optim(par = initial_params, fn = log_likelihood, data = data)

beta0_hat <- fit$par[1]
beta1_hat <- fit$par[2]
beta2_hat <- fit$par[3]
beta3_hat <- fit$par[4]

x1_star <- 4
x2_star <- 0.75
mu_star <- exp(beta0_hat + beta1_hat * x1_star + beta2_hat * x2_star + beta3_hat * x1_star * x2_star)
t_star <- mean(data$cells) # Average number of cells
expected_ratio <- mu_star / t_star ## 0.001790621 

print(expected_ratio) ## 0.001790621 


######################## b ) ##########################


# Read the data
data <- read.table("chromoabnormal.txt", sep="\t", dec=".", header=TRUE)

log_likelihood <- function(params, data) {
  beta0 <- params[1]
  beta1 <- params[2]
  beta2 <- params[3]
  beta3 <- params[4]
  mu <- exp(beta0 + beta1 * data$doseamt + beta2 * data$doserate + beta3 * data$doseamt * data$doserate)
  log_lik <- sum(dpois(data$ca, mu, log = TRUE))
  return(-log_lik)
}

fit <- optim(par = c(0, 0, 0, 0), fn = log_likelihood, data = data)

beta0_hat <- fit$par[1]
beta1_hat <- fit$par[2]
beta2_hat <- fit$par[3]
beta3_hat <- fit$par[4]

mu_f <- exp(beta0_hat + beta1_hat * 4 + beta2_hat * 0.75 + beta3_hat * 4 * 0.75)

hessian <- numDeriv::hessian(log_likelihood, fit$par, data = data)

# Inverse Hessian matrix
inverse_hessian <- solve(hessian)

vcov_params <- -inverse_hessian

d_mu_f_d_beta0 <- exp(beta0_hat + beta1_hat * 4 + beta2_hat * 0.75 + beta3_hat * 4 * 0.75)
d_mu_f_d_beta1 <- 4 * exp(beta0_hat + beta1_hat * 4 + beta2_hat * 0.75 + beta3_hat * 4 * 0.75)
d_mu_f_d_beta2 <- 0.75 * exp(beta0_hat + beta1_hat * 4 + beta2_hat * 0.75 + beta3_hat * 4 * 0.75)
d_mu_f_d_beta3 <- 4 * 0.75 * exp(beta0_hat + beta1_hat * 4 + beta2_hat * 0.75 + beta3_hat * 4 * 0.75)

# Adjusted calculation of the estimated variance of Yf using the delta method
variance_f <- max(d_mu_f_d_beta0^2 * vcov_params[1,1] +
                    d_mu_f_d_beta1^2 * vcov_params[2,2] +
                    d_mu_f_d_beta2^2 * vcov_params[3,3] +
                    d_mu_f_d_beta3^2 * vcov_params[4,4] +
                    2 * (d_mu_f_d_beta0 * d_mu_f_d_beta1 * vcov_params[1,2] +
                           d_mu_f_d_beta0 * d_mu_f_d_beta2 * vcov_params[1,3] +
                           d_mu_f_d_beta0 * d_mu_f_d_beta3 * vcov_params[1,4] +
                           d_mu_f_d_beta1 * d_mu_f_d_beta2 * vcov_params[2,3] +
                           d_mu_f_d_beta1 * d_mu_f_d_beta3 * vcov_params[2,4] +
                           d_mu_f_d_beta2 * d_mu_f_d_beta3 * vcov_params[3,4]), 0)

alpha <- 0.8
z_alpha <- qnorm(1 - (1 - alpha) / 2)
lower_bound <- mu_f - sqrt(variance_f) * z_alpha


print(lower_bound) # 114.7257 






######################## c) ##########################

xf1 <- 4
xf2 <- 0.75

lambda_Yf <- exp(beta0_hat + beta1_hat * xf1 + beta2_hat * xf2)

mu_Zf <- lambda_Yf / tf
var_Zf <- lambda_Yf / tf^2

alpha <- 0.8
z_alpha <- qnorm(1 - (1 - alpha) / 2)
lower_bound_Zf <- mu_Zf - sqrt(var_Zf) * z_alpha
print(lower_bound_Zf) # 0.001266255

######################## d ) ##########################
# Read the dataset


model12 <- glm(ca ~ doseamt + doserate + doseamt * doserate, data = data, family = poisson)
beta2_hat <- coef(model12)["doserate"]
se_beta2_hat <- sqrt(vcov(model12)["doserate", "doserate"])
t_stat <- beta2_hat / se_beta2_hat
alpha <- 0.05 / 2
df <- nrow(data) - length(coefficients(model12))
critical_value <- qt(1 - alpha, df)
print(t_stat) # -2.786985



#######################################################
######################## 2 ) ##########################

######################## a ) ##########################
# Read the dataset
data <- read.table("betablocker.txt", sep="\t", dec=".", header=TRUE)

fit <- glm(Deaths/Total ~ Treatment + Center, data = data, family = binomial(link = "logit"))

xi1_star <- "Treated"
xi2_star <- 10
mu_i_star <- predict(fit, newdata = data.frame(Treatment = xi1_star, Center = xi2_star), type = "response")
print(mu_i_star) # 0.08629657
######################## b ) ##########################

fit <- glm(Deaths/Total ~ Treatment + Center, data = data, family = binomial(link = "logit"))

xi1_star <- "Treated"
xi2_star <- 10

mu_i_star <- predict(fit, newdata = data.frame(Treatment = xi1_star, Center = xi2_star), type = "response")
mu_i_star
beta_Treated <- coef(fit)["TreatmentTreated"]

se_beta_Treated <- sqrt(vcov(fit)["TreatmentTreated", "TreatmentTreated"])

z_value <- qnorm(0.975)

lower_bound <- mu_i_star - z_value * se_beta_Treated
upper_bound <- mu_i_star + z_value * se_beta_Treated
lower_bound # 1.921528 
upper_bound # 2.094121
z = (lower_bound + upper_bound)/2
z # 0.08629657


######################## c ) ##########################

fit <- glm(Deaths/Total ~ Treatment + Center, data = data, family = binomial(link = "logit"))

xi1_Control <- "Control"
xi1_Treated <- "Treated"
xi2 <- 10

log_odds_Control <- predict(fit, newdata = data.frame(Treatment = xi1_Control, Center = xi2), type = "link")
log_odds_Treated <- predict(fit, newdata = data.frame(Treatment = xi1_Treated, Center = xi2), type = "link")

odds_Control <- exp(log_odds_Control)
odds_Treated <- exp(log_odds_Treated)

odds_ratio <- odds_Treated / odds_Control
print(odds_ratio) # 0.7877294 

############################## e ) ############################## 
n_new <- 100

xi1_star <- "Treated"
xi2_star <- 10
probs <- predict(fit, newdata = data.frame(Treatment = xi1_star, Center = xi2_star), type = "response")
outcomes <- rbinom(n_new, 1, probs)

sum_outcomes <- sum(outcomes)

se_sum <- sqrt(sum(probs * (1 - probs)))
z_value <- qnorm(0.9)

margin_error <- z_value * se_sum

lower_bound <- sum_outcomes - margin_error
upper_bound <- sum_outcomes + margin_error

midpoint <- (lower_bound + upper_bound) / 2
print(midpoint) # 10

