##################  3  ##################  
# Parameters
beta_hat <- c(1, 0.5) 
phi_hat <- 0.1

X <- cbind(1, 1:10)

eta <- X %*% beta_hat
mu <- exp(eta)
W <- diag(1 / (phi_hat * mu^2))

cov_beta_hat <- solve(t(X) %*% W %*% X)

# Display the estimated covariance matrix
print(cov_beta_hat)
# [,1]      [,2]
# [1,]  4.736239 -2.191896
# [2,] -2.191896  1.385940

##################  4  ##################  

# Parameters
beta_0_hat <- 1   
sigma2_hat <- 0.1  
n <- 10   
df <- n - 1

alpha <- 0.05
t_alpha_2 <- qt(1 - alpha/2, df)


X <- matrix(rep(1, n), ncol = 1)
XX_inv <- solve(t(X) %*% X)
x_f <- matrix(c(1), nrow = 1)

# Prediction interval calculation
lower_bound <- beta_0_hat - t_alpha_2 * sqrt(sigma2_hat * (1 + t(x_f) %*% XX_inv %*% x_f))
upper_bound <- beta_0_hat + t_alpha_2 * sqrt(sigma2_hat * (1 + t(x_f) %*% XX_inv %*% x_f))

# Display the prediction interval
cat("The 100(1 - alpha)% prediction interval for Y_f is: [", lower_bound, ",", upper_bound, "]\n")


################## Start  5  ##################  

# Coefficients for RET=3
beta_03 <- -4.27817
beta_13 <- 0.178304
X_i <- 20
eta_i3 <- beta_03 + beta_13 * X_i
P_Y_i_3_given_X_i_20 <- exp(eta_i3) / (1 + exp(eta_i3))
print(P_Y_i_3_given_X_i_20) # 0.3291372

################## End  5   ##################  

##################  6  ##################  
beta_0 <- 99.56799
beta_1 <- 21.61455
beta_2 <- -3.54113
x_i <- 50

mu_i <- beta_0 + (beta_1 - beta_0) * exp(-(exp(beta_2 * x_i)))
print(mu_i) # 21.61455
##################  6  ##################  