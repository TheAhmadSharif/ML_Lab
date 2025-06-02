# Load necessary libraries
library(dplyr)
library(lubridate)
library(lmtest)


setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")

data<-read.table("paper.txt", sep="\t", dec=".", header=TRUE)
data


model_m1_2 <- lm(strength ~ hardwood + pressure, data = data)

# Maximum Likelihood Estimate for b2
b2_estimate <- coef(model_m1_2)["pressure"]
b2_estimate



# b) 


sigma_sq_estimate <- summary(model_m1_2)$sigma^2
sigma_sq_estimate


# c) 

fitted_value <- predict(model_m1_2, newdata = data[1, ])
fitted_value



# d) 

# Define the new data point
new_data <- data.frame(hardwood = 7, pressure = 500)

# Maximum Likelihood Estimate for µi∗
mu_star_estimate <- predict(model_m1_2, newdata = new_data)
mu_star_estimate


# e) 

# Prediction interval for the new observation

prediction_interval <- predict(model_m1_2, newdata = new_data, interval = "prediction", level = 0.80)
lower_bound <- prediction_interval[1, "lwr"]
upper_bound <- prediction_interval[1, "upr"]

# Display the interval and estimate for lower bound
prediction_interval
lower_bound


#f) 

# Likelihood ratio test for H0 vs. H1
model_m1 <- lm(strength ~ hardwood, data = data)

LR_test_statistic <- lrtest(model_m1, model_m1_2)
LR_test_statistic


# –––––––––––––––––––––––––––––––––––––––––––––


# Load the data
data <- read.table("makiwaraboard.txt", sep="\t", dec=".", header=TRUE)
data$BoardType <- factor(data$BoardType, levels = c("Stacked", "Tapered"))

# a) Maximum Likelihood Estimate for µjh under M1|2
# Define the new data point with corrected spelling
new_data_point <- data.frame(WoodType = "Oak", BoardType = "Tapered")

# Ensure factor levels in the new data match those in the original data
new_data_point$BoardType <- factor(new_data_point$BoardType, levels = levels(data$BoardType))

# Fit the model M1|2
model_M1_2 <- lm(Deflection ~ WoodType + BoardType + WoodType:BoardType, data = data)
# Predict the expected value
mu_estimate <- predict(model_M1_2, newdata = new_data_point)
mu_estimate


# Fit the model M1|2
model_M1_2 <- lm(Deflection ~ WoodType + BoardType + WoodType:BoardType, data = data)
# Predict the expected value
mu_estimate <- predict(model_M1_2, newdata = new_data_point)
mu_estimate

# b) Estimate of expected value µjh in highest level
# Extract coefficients
coefficients_M1_2 <- coef(model_M1_2)
coefficients_M1_2# Find the level with the highest estimate
highest_level <- names(coefficients_M1_2)[which.max(coefficients_M1_2)]
highest_level


# Extract coefficients related to WoodType and BoardType interactions
interaction_coefficients <- coef(model_M1_2)[grep("WoodType|BoardType", names(coef(model_M1_2)))]

# Reshape the coefficients into a data frame for better visibility
coefficients_df <- data.frame(
  Interaction = names(interaction_coefficients),
  Coefficient = interaction_coefficients
)

# Print the coefficients
coefficients_df




# Extract the levels of WoodType and BoardType
levels_WoodType <- unique(data$WoodType)
levels_BoardType <- unique(data$BoardType)

# Create an empty data frame to store the results
results_df <- data.frame(WoodType = character(), BoardType = character(), Estimate = numeric(), stringsAsFactors = FALSE)


# Find the level with the highest estimated expected value
highest_level <- results_df[which.max(results_df$Estimate), ]




# c) Maximum Likelihood Estimate for the parameter γ32 under M1|2
# Extract the coefficient for the interaction term
gamma_32_estimate <- coef(model_M1_2)["WoodTypeOak:BoardTypeStacked"]
gamma_32_estimate

# d) Residual for the last observation under M1|2
# Get the residuals
residual_last_observation <- residuals(model_M1_2)[nrow(data)]
residual_last_observation

# e) Test for hypotheses H0: γjh = 0 vs. H1: γjh ≠ 0
# Use the F-statistic for the interaction term
F_statistic <- summary(model_M1_2)
F_statistic





# Extract the levels of WoodType
# Create an empty data frame to store the total effects
total_effects_df <- data.frame(WoodType = character(), TotalEffect = numeric(), stringsAsFactors = FALSE)

# Loop through each level of WoodType
for (wt in levels_WoodType) {
  # Calculate the total effect for each level of WoodType
  total_effect <- coefficients_M1_2[paste0("WoodType", wt)] + 
    coefficients_M1_2[paste0("WoodType", wt, ":BoardTypeTapered")]
  
  # Store the results in the data frame
  total_effects_df <- rbind(total_effects_df, c(wt, total_effect))
}

# Find the level with the highest total effect
highest_level <- total_effects_df[which.max(total_effects_df$TotalEffect), ]
highest_level



# c) 


# Check the levels of WoodType and BoardType in the data
unique(data$WoodType)
unique(data$BoardType)


# Retrieve the estimate for gamma_32
gamma_32_estimate <- coefficients_M1_2["WoodTypeOak:BoardTypeStacked"]
gamma_32_estimate


gamma_32_estimate <- coef(model_M1_2)["WoodTypeOak:BoardTypeStacked"]
gamma_32_estimate


residual_last_observation <- residuals(model_M1_2)[nrow(data)]
residual_last_observation

