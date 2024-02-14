library(dplyr)
library(lmtest)
library(lubridate)

setwd("/home/ahmad/Desktop/")
data <- read.csv("data.csv")
data$Date <- as.Date(data$Date, format = "%m/%d/%Y")
data$Month <- as.integer(format(data$Date, "%m"))
data$Season <- ifelse(data$Month %in% c(11, 12, 1, 2, 3, 4), "Winter", "Summer")
data$Winter <- ifelse(data$Season == "Winter", 1, 0)
model <- lm(Compounded.return ~ Winter, data = data)
model
summary(model)

