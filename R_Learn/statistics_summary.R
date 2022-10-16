# Statistics
# Date: 16 October 2022


data = women
print(data)
print(data$height)
plot(women)
summary(data$height)
summary(data$weight)
x = data$height
y = data$weight

relation <- lm(y~x)
print(summary(relation))
plot(data$height, data$weight)


x <- seq(-10, 20, by = .2)
y <- dnorm(x, mean = 0.5, sd = 0.5)
plot(x,y)

boxplot(data$weight)
boxplot(data$weight)
