### Name : Ahmad Sharif
### Email: ahmad.sharif@tuni.fi
### Student_ID : K436765
### Statistical Modeling
### Exercise 03

setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")



# Load the data
data <- read.table("Alba.txt", sep="\t", dec=".", header=TRUE)


library(quantreg)


model_identity <- lm(DryMatter ~ Dose + Herbicide, data = data)
mse_identity <- mean((data$DryMatter - predict(model_identity))^2)

# Fit the log model with specified starting values
starting_values <- rep(1, length(coef(model_identity)))
model_log <- try(glm(log(DryMatter) ~ Dose + Herbicide + Dose:Herbicide, data = data, start = starting_values), silent = TRUE)

# Check if the model_log was successfully created
if (inherits(model_log, "glm")) {
  mse_log <- mean((data$DryMatter - exp(predict(model_log)))^2)
} else {
  mse_log <- Inf  
}

# Fit the inverse model
model_inverse <- lm(1/DryMatter ~ Dose + Herbicide, data = data)
mse_inverse <- mean((data$DryMatter - 1/predict(model_inverse))^2)

# Fit the 1/µi² model
model_one_over <- lm(1/(DryMatter^2) ~ Dose + Herbicide, data = data)
mse_one_over <- mean((data$DryMatter - 1/sqrt(predict(model_one_over)))^2)

# Compare MSE values and choose the model
mse_values <- c(mse_identity, mse_log, mse_inverse, mse_one_over)
chosen_model <- which.min(mse_values)

# Print the chosen model and the estimated β1
model_names <- c("Midentity", "Mlog", "Minverse", "M 1/µi²")
chosen_model_name <- model_names[chosen_model]
estimated_beta1 <- coef(lm(DryMatter ~ Dose + Herbicide, data = data))[2]

cat("Selected Model:", chosen_model_name, "\n")
cat("Estimated β1:", estimated_beta1, "\n\n")







# (b) Maximum Likelihood Estimate for µi* at X1=50, X2=Glyphosate
# Use the selected model
X1_new <- 50
X2_new <- "Glyphosate"
mu_star <- predict(get(chosen_model_name), newdata = data.frame(Dose = X1_new, Herbicide = X2_new), type = "response")
cat("Maximum Likelihood Estimate µi* at X1=50, X2=Glyphosate:", mu_star, "\n\n")

# (c) 95% Confidence Interval for µi* at X1=50, X2=Glyphosate
# Use the selected model
new_data_c <- data.frame(Dose = X1_new, Herbicide = X2_new)
conf_interval <- predict(chosen_model_fit, newdata = data.frame(Dose = X1_new, Herbicide = X2_new), interval = "confidence", level = 0.95)
lower_bound_ci_c <- conf_interval_c[1]

cat("95% Confidence Interval Lower Bound:", lower_bound_ci_c, "\n")





