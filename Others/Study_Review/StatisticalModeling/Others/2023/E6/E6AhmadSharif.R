### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 05
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")library(nnet)

install.packages("survival")
library(survival)

data<-read.table("tirereliability.txt", header=TRUE, sep="\t", dec=".")
data 

names(data)
labels(data)



attach(data)
tireAge
wedge
interBelt
EB2B
peelForce
crbnBlk
survival
complete

Y = complete
T = survival

coxph_model <- coxph(Surv(survival, complete) ~ wedge, data = data)   # fit Cox proportional hazards regression model
summary(coxph_model)   # display model summary, including the estimate for beta



### b) 
library(survival)
survObj <- Surv(data$tireAge, data$complete)
model <- coxph(survObj ~ wedge, data = data)
summary(model)


# Estimate beta
coxph_model <- coxph(Surv(survival, complete) ~ wedge, data = data)

model <- coxph(Surv(T, Y) ~ wedge, data = data)
xi <- 0.6
t <- 1
sfit <- survfit(model, newdata = data.frame(wedge = xi))
S <- summary(sfit, times = t)$surv
S



### c)

t <- 1.0
xi1 <- 0.6
xi2 <- 1.6

h1 <- predict(model, newdata = data.frame(wedge = xi1), type = "risk", t = t)

h2 <- predict(model, newdata = data.frame(wedge = xi2), type = "risk", t = t)
h1
h2


HR <- exp(model$coef * (xi1 - xi2))
HR


### d) 

# Fit the full model with all explanatory variables
model_full <- coxph(Surv(survival, complete) ~ wedge + peelForce + interBelt + wedge*peelForce, data = data)

# Fit the reduced model without the variable wedge
model_reduced <- coxph(Surv(survival, complete) ~ peelForce + interBelt + peelForce*interBelt, data = data)

# Perform the likelihood ratio test
lrt <- anova(model_reduced, model_full, test = "Chisq")

# Print the results
lrt


### e) 

# Fit the Cox proportional hazards regression model

model <- coxph(Surv(time, status) ~ wedge + peelForce + interBelt + wedge:peelForce, data = data)

model <- coxph(complete ~ wedge + peelForce + interBelt + wedge:peelForce, data = data)

# Define the values of the covariates
xi1 <- 0.6
xi2 <- 0.8
xi3 <- 0.7

# Define the time point of interest
t <- 1.00

# Calculate the hazard ratio for xi2=0.8 and xi1=0.6
hazard_ratio <- exp(coef(model)["wedge:peelForce"])^(xi1*xi2)




### 2) a)

# Define the hazard functions for xi and xi*
h_xi <- function(t) (t/lambda)^p * exp(beta*0.6)
h_xi_star <- function(t) (t/lambda)^p * exp(beta*1.6)

# Estimate the hazard ratio at time t
t <- 1
HR <- h_xi(1) / h_xi_star(t)
HR





lambda <- 10
p <- 2
beta <- c(0.5, 0.2, 0.1)
xi <- c(0.6, 0.8, 0.7)
xi_star <- c(1.6, 0.8, 0.7)

# Define hazard function
h_xi <- function(t) {
  (p/lambda) * (t/lambda)^(p-1) * exp(sum(beta*xi))
}

h_xi_star <- function(t) {
  (p/lambda) * (t/lambda)^(p-1) * exp(sum(beta*xi_star))
}

# Calculate hazard ratio at time t=1
t <- 1
HR <- h_xi(t) / h_xi_star(t)
HR



## b)

model <- survreg(Surv(tireAge) ~ wedge, data = data, dist = "weibull")
xi_star <- data.frame(wedge = 1.6)
E_T_xi_star <- predict(model, newdata = xi_star, type = "response")
E_T_xi_star


### 2) c) 


model <- survreg(Surv(tireAge) ~ wedge, data = data, dist = "weibull")

# Define the new observation with xf = 1.6
new_obs <- data.frame(wedge = 1.6)

# Predict the survival function and its standard error for the new observation
new_surv <- predict(model, new_obs, type = "response", se.fit = TRUE)

# Calculate the prediction interval for Tf = 1.0 with 80% confidence





### 2) d) 


model <- survreg(Surv(tireAge) ~ wedge + peelForce + interBelt + wedge:peelForce, data = data, dist = "weibull")

# Create new data frame with covariate values
newdata <- data.frame(wedge = 0.6, peelForce = 0.8, interBelt = 0.7, wedge_peelForce = 0.6 * 0.8)

# Calculate survival probability at time t=1.00
t <- 1.00
newdata <- data.frame(wedge = 0.6, peelForce = 0.8, interBelt = 0.7)
model <- coxph(survival ~ wedge + peelForce + interBelt + wedge:peelForce, data = data)
S <- survexp(-t * predict(model, newdata = newdata, type = "lp"))
