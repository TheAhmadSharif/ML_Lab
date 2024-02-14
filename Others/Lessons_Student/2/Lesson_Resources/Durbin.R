data(mtcars)
head(mtcars)
model <- lm(mpg ~ disp+wt, data=mtcars)
library(car)

durbinWatsonTest(model)