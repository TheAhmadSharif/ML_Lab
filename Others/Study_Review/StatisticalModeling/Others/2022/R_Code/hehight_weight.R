data<-read.table("__height_weight.txt", sep=" ", dec=".", header=TRUE)
data

attach(data)
data
relation <- lm(y~x)
relation
print(summary(relation))


# Find weight of a person with height 170.
a <- data.frame(x = 170)

result <-  predict(relation,a)
print(result)

plot(y,x,col = "blue",main = "Height & Weight Regression",
     abline(lm(x~y)),cex = 2,pch = 16,xlab = "Weight in Kg",ylab = "Height in cm")

coef(relation)
