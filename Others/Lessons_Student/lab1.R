# Load necessary libraries
library(dplyr)
library(lubridate)

setwd("/home/ahmad/Desktop/Lessons/")
data <- read.csv("data.csv")


data$Date <- as.Date(data$Date, format = "%m/%d/%Y")
data$Log_Return <- log(data$Closing.price) - lag(log(data$Closing.price))

data$St_Dummy <- ifelse(month(data$Date) >= 11 | month(data$Date) <= 4, 1, 0)
data

# y ~ x 
model <- lm(CompoundedReturn ~ St_Dummy, data = data)


summary(model)


data


Dec = c(415, 88.33, 25, 380)
sum(Dec)

Dec = c(415, 88.33, 25, 380)
sum(Dec)
