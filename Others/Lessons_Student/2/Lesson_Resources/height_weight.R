setwd("/home/ahmad/Desktop/")
data <- read.csv("w_h.csv")
data$Height

model = lm (y ~x)
summary(model)
