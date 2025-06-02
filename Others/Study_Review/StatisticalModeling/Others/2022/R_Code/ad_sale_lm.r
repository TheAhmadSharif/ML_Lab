---
  # 27 January 2023
  # Satsuma Mandarin
  
  # Time == Day
  # Vitamin C = Left Vitamin
  # https://www.learnbymarketing.com/tutorials/linear-regression-in-r/
  ---
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
dataset = read.csv("https://raw.githubusercontent.com/hyokwan/r-lecture/master/data/data-marketing-budget-12mo.csv", 
                   header=T,
                   colClasses = c("numeric", "numeric", "numeric"))

dataset
dataset$Spend
Sales <- dataset$Sales
Spend <- dataset$Spend
simple_linear_model <- lm(Sales~Spend, data=dataset)

simple_linear_model
# y = a + bx
# a = 1383.47
# b = 10.62

# Coefficients:
#   (Intercept)        Spend  
# 1383.47        10.62  

plot(Spend, Sales, type="n")
points(Spend, Sales, type="b")

### type == b, p, n 

multiple_linear_model = lm(Sales~Spend+Month, data=dataset)

multiple_linear_model
