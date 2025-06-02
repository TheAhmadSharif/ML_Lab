#  For example people's weight (dependent variable) 
# might depend on their height (independent variable).

height <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
weight <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

sorted_x <- sort(height)
sorted_x

relation <- lm(weight~height)
relation
summary(relation)
print(relation) 
plot(height, weight, col="blue", 
     abline(lm(weight ~ height)),
      main = "Height & Weight Regression", xlab = "Height in cm", ylab = "Weight in kg")

x <- data.frame(height = 170)
predict_weight <- predict(relation, data = c(180))
predict_weight
dev.off()



