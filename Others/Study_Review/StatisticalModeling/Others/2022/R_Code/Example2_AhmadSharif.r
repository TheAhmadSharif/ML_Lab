## Ahmad Sharif
 # K436765
 # Email: ahmad.sharif@tuni.fi

if(!require('aod')) {
  install.packages('aod')
  library('aod')
}

library(aod)
data <- data(mtcars)
head(mtcars)

summary(mtcars)
dim(mtcars)
model <- lm(mpg ~ disp + carb + hp + cyl, data = mtcars)
model

summary(model)


data(orob2)
head(orob2)
fm <- quasibin(cbind(y, n - y) ~ seed * root, data = orob2)
fm
# Wald test for the effect of root
wald.test(b = coef(fm), Sigma = vcov(fm), Terms = 3:4)
wald.test(Sigma, b, Terms)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 3:4)

aod
