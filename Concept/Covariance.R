# Define the vectors for temperature and ice cream sales
temperatures <- c(70, 75, 80, 85, 90, 95, 100)
sales <- c(100, 150, 200, 250, 300, 350, 400)

# Calculate the means
mean_temperature <- mean(temperatures)
mean_sales <- mean(sales)

# Calculate the differences from the means
diff_temps <- temperatures - mean_temperature
diff_sales <- sales - mean_sales

# Calculate the products of differences
products <- diff_temps * diff_sales

# Calculate covariance
covariance <- sum(products) / (length(products) - 1)

# Print the covariance
print(covariance)

