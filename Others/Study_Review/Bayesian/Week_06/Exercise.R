setwd("/home/ahmad/Desktop/2023_2024/Bayesian/Week_06")

model <- "
model{
  x ~ dbin(pi, N)   # Likelihood
  pi ~ dbeta(0.01, 0.01) # Prior 1 (change for other priors)
  
  # Predictive distribution for new data
  x.new ~ dbin(pi, N)   
  pi.new <- x.new / N
}"


################

gal.data1 <- list(N = 751, x = 150)
gal.inits <- list(pi = 0.5, x.new = 0)

gal.m <- jags.model(textConnection(model), data = gal.data1, n.chains = 1,
                    inits = gal.inits, n.adapt = 2000)

gal.par <- c("pi", "x.new")  # Parameters to monitor
res.gal1 <- coda.samples(gal.m, var = gal.par, n.iter = 10000, thin = 10)

summary(res.gal1)
plot(res.gal1)
