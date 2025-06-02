# R Code for Gamma PDFs
theta_values <- seq(0, 0.1, length.out = 50)


prior_pdf <- dgamma(theta_values, shape=1, rate=1)
posterior_pdf <- dgamma(theta_values, shape=13, rate=760)

# Plotting the prior and posterior
plot(theta_values, prior_pdf, type="l", col="blue", lwd=2, 
     ylab="Density", xlab="θ", main="Prior and Posterior Distributions")
lines(theta_values, posterior_pdf, col="red", lwd=2)
legend("topright", legend=c("Prior", "Posterior"), col=c("blue", "red"), lwd=2)


# # 4) b) R Code for Gamma PDFs
theta_values <- seq(0, 0.1, length.out = 50)
prior_pdf <- dgamma(theta_values, shape=1, rate=1)
posterior_pdf <- dgamma(theta_values, shape=13, rate=760)

# Plotting the prior and posterior
plot(theta_values, prior_pdf, type="l", col="blue", lwd=2, 
     ylab="Density", xlab="θ", main="Prior and Posterior Distributions")
lines(theta_values, posterior_pdf, col="red", lwd=2)
legend("topright", legend=c("Prior", "Posterior"), col=c("blue", "red"), lwd=2)



# 4) e) 


# R Code for Updated Posterior
posterior_pdf_updated <- dgamma(theta_values, shape=25, rate=3963)

# Plotting prior and updated posterior
plot(theta_values, prior_pdf, type="l", col="blue", lwd=2, 
     ylab="Density", xlab="θ", main="Prior and Updated Posterior Distributions")
lines(theta_values, posterior_pdf_updated, col="green", lwd=2)
legend("topright", legend=c("Prior", "Updated Posterior"), col=c("blue", "green"), lwd=2)




### 5) a) 

# R Code for Prior
theta <- seq(0, 1, length.out = 50)
prior_pdf <- dbeta(theta, shape1 = 2, shape2 = 3)

# Plot
plot(theta, prior_pdf, type = "l", col = "blue", lwd = 2, ylab = "Density", xlab = "θ",
     main = "Prior Probability Density Function")


# b) 

# R Code for Likelihood
likelihood <- theta^7 * (1 - theta)^3

# Plot
plot(theta, likelihood, type = "l", col = "green", lwd = 2, ylab = "Likelihood",
     xlab = "θ", main = "Likelihood Function")

