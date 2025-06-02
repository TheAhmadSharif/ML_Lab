# 📘 Naive Statistical Modeling in R (Manual + lm)

# Step 1: Create small dataset
hours <- c(1, 2, 3, 4, 5)
scores <- c(52, 54, 57, 59, 60)

df <- data.frame(Hours = hours, Score = scores)

# Step 2: Compute means
mean_X <- mean(df$Hours)
mean_Y <- mean(df$Score)

cat("Mean of X:", mean_X, "\n")
cat("Mean of Y:", mean_Y, "\n")

# Step 3: Manually compute slope (beta1) and intercept (beta0)
numerator <- sum((df$Hours - mean_X) * (df$Score - mean_Y))
denominator <- sum((df$Hours - mean_X)^2)

beta1 <- numerator / denominator
beta0 <- mean_Y - beta1 * mean_X

cat("Estimated slope (beta1):", beta1, "\n")
cat("Estimated intercept (beta0):", beta0, "\n")

# Final model: Y = beta0 + beta1 * X
cat("Manual model: Score = ", beta0, " + ", beta1, " * Hours\n")

# Step 4: Predict score for 6 hours studied
predicted_score <- beta0 + beta1 * 6
cat("Predicted score for 6 hours studied:", predicted_score, "\n")

# Step 5: Use built-in linear model for verification
model <- lm(Score ~ Hours, data = df)
summary(model)

# Step 6: Plot the data and regression line
plot(df$Hours, df$Score, main = "Simple Linear Regression",
     xlab = "Hours Studied", ylab = "Exam Score", pch = 19, col = "blue")
abline(model, col = "red", lwd = 2)
text(2, 58, paste("Score =", round(beta0, 1), "+", round(beta1, 1), "* Hours"), pos = 4)

