### Statistical Modeling 1 
### Linear Models
### 2022

############################
### Example 1.1

data<-read.table("blackcherry.txt", sep="\t", dec=".", header=TRUE)
attach(data)

plot(Girth, Volume)
plot(Height, Volume)

model<-lm(Volume~Girth+Height)
summary(model)

model<-lm(Volume~Girth)
summary(model)
points(Girth, fitted(model), col="red", pch=19)


# a)

coef(model)

# b)

summary(model)$sigma^2


# c)

fitted(model)
residuals(model)

fitted(model)[31]
residuals(model)[31]

plot(fitted(model), Volume)

plot(fitted(model), residuals(model))

# d)

new.data<-data.frame(Girth=c(30), Height=c(22))
mu.hat<-predict(model, newdata=new.data, interval="confidence", level=0.95)

mu.hat[1] # maximum likelihood point estimate
mu.hat[2] # lower bound of the 95% confidence interval
mu.hat[3] # upper bound of the 95% confidence interval

# e)

new.data<-data.frame(Girth=c(30), Height=c(22))
y.hat<-predict(model, newdata=new.data, interval="prediction", level=0.8)

y.hat[1] # best linear unbiased point prediction  
y.hat[2] # lower bound of the 80% prediction interval
y.hat[3] # upper bound of the 80% prediction interval

# f)

model.H0<-lm(Volume~Girth)
summary(model.H0)

anova(model.H0, model, test="F")
anova(model.H0, model, test="F")$"F"[2] # the value of the test statistic
anova(model.H0, model, test="F")$"Pr(>F)"[2]  # p-value


############################
### Example 1.2

data<-read.table("teethpig.txt", sep="\t", dec=".", header=TRUE)
attach(data)

interaction.plot(level, dose, growth, mean)

plot(level, growth, type="n")
points(level[dose=="VC"], growth[dose=="VC"], col="red", pch=19)
points(level[dose=="OJ"], growth[dose=="OJ"], col="blue", pch=19)

model.12<-lm(growth~level+factor(dose)+level:factor(dose))
summary(model.12)

plot(level, growth, type="n")
lines(level[dose=="VC"], fitted(model.12)[dose=="VC"], col="red")
lines(level[dose=="OJ"], fitted(model.12)[dose=="OJ"], col="blue")


# a)

coef(model.12)

# b)

new.data<-data.frame(level=2, dose="VC")
predict(model.12, newdata=new.data, interval="prediction", level=0.80)

prediction<-predict(model.12, newdata=data, interval="prediction", level=0.80)
estimation<-predict(model.12, newdata=data, interval="confidence", level=0.95)

plot(level, growth, type="n")
points(level[dose=="VC"], growth[dose=="VC"], col="red", pch=19)
points(level[dose=="OJ"], growth[dose=="OJ"], col="blue", pch=19)
lines(level[dose=="VC"], prediction[dose=="VC",1], col="red")
lines(level[dose=="VC"], prediction[dose=="VC",2], col="green")
lines(level[dose=="VC"], prediction[dose=="VC",3], col="green")
lines(level[dose=="OJ"], prediction[dose=="OJ",1], col="blue")
lines(level[dose=="OJ"], prediction[dose=="OJ",2], col="black")
lines(level[dose=="OJ"], prediction[dose=="OJ",3], col="black")

plot(level, growth, type="n")
points(level[dose=="VC"], growth[dose=="VC"], col="red", pch=19)
points(level[dose=="OJ"], growth[dose=="OJ"], col="blue", pch=19)
lines(level[dose=="VC"], estimation[dose=="VC",1], col="red")
lines(level[dose=="VC"], estimation[dose=="VC",2], col="green")
lines(level[dose=="VC"], estimation[dose=="VC",3], col="green")
lines(level[dose=="OJ"], estimation[dose=="OJ",1], col="blue")
lines(level[dose=="OJ"], estimation[dose=="OJ",2], col="black")
lines(level[dose=="OJ"], estimation[dose=="OJ",3], col="black")

# c)

model.main<-lm(growth~level+factor(dose))
summary(model.main)
model.1<-lm(growth~level)

anova(model.1,model.main, test="F")
anova(model.1,model.main, test="F")$F[2]

# d)

anova(model.main,model.12, test="F")

anova(model.1,model.12, test="F")
anova(model.1,model.12, test="F")$F[2]


############################
### Example 1.3

data<-read.table("ratsRBGH.txt", sep="\t", dec=".", header=TRUE)
attach(data)

model.12<-lm(weightgain~factor(rbGH)+factor(gender)+factor(rbGH):factor(gender), data=data) 
summary(model.12)

model.12<-lm(weightgain~factor(rbGH)*factor(gender), data=data) 
summary(model.12)


# a)

interaction.plot(rbGH, gender, fitted(model.12))
data.frame(data, fitted(model.12))
predict(model.12, newdata=data.frame(gender=1, rbGH=5))

# b)

model.main<-lm(weightgain~factor(rbGH)+factor(gender), data=data) 
summary(model.main)
interaction.plot(rbGH, gender, fitted(model.main))
predict(model.main, newdata=expand.grid(gender=1:2, rbGH=1:6))
data.frame(expand.grid(gender=1:2, rbGH=1:6), predict(model.main, newdata=expand.grid(gender=1:2, rbGH=1:6)))

# c)

interaction.plot(rbGH, gender, fitted(model.main))
interaction.plot(rbGH, gender, fitted(model.12))

anova(model.main, model.12, test="F")
anova(model.main, model.12, test="F")$F[2] # test statistic - F test
anova(model.main, model.12, test="F")$"Pr(>F)"[2] # p-value - F test

# d)

mu.hat<-predict(model.12, newdata=data.frame(gender=c(2,1), rbGH=c(5,3)))
mu.hat[1]-mu.hat[2]


############################
### Example 1.6

betahat<-coef(model.12)

k1<-c(0,0,0,0,0,0,0,1,0,0,0,0)
k2<-c(0,0,0,0,0,0,0,0,1,0,0,0)
k3<-c(0,0,0,0,0,0,0,0,0,1,0,0)
k4<-c(0,0,0,0,0,0,0,0,0,0,1,0)
k5<-c(0,0,0,0,0,0,0,0,0,0,0,1)

K<-cbind(k1,k2,k3,k4,k5)

q<-5
Wald<-(t(t(K)%*%betahat)%*%solve(t(K)%*%vcov(model.12)%*%K)%*%t(K)%*%betahat)/q
Wald
p.value<-pf(Wald, 5, 48, lower.tail = FALSE)
p.value

X<-model.matrix(model.12)

############################
### Example 1.7

data<-read.table("teethpig.txt", sep="\t", dec=".", header=TRUE)
attach(data)

model.12<-lm(growth~level+factor(dose)+level:factor(dose))
summary(model.12)

betahat<-cbind(coef(model.12))

x1<-cbind(c(1,0.5,0,0)) ### OJ
x2<-cbind(c(1,0.5,1,0.5)) ## VC

pred<-(t(x2)-t(x1))%*%betahat
sigma2<-sigma(model.12)^2

# 80% prediction inteval, lower and upper limits

lower<-pred-qt(0.9,df=56)*sqrt(sigma2*(2+(t(x2)-t(x1))%*%solve(vcov(model.12))%*%(x2-x1)))
upper<-pred+qt(0.9,df=56)*sqrt(sigma2*(2+(t(x2)-t(x1))%*%solve(vcov(model.12))%*%(x2-x1)))

# all possible 0...99.9% interval

lower<-as.vector(pred)-qt(seq(0.5,0.999,0.001),df=56)*as.vector(sqrt(sigma2*(2+(t(x2)-t(x1))%*%solve(vcov(model.12))%*%(x2-x1))))
upper<-as.vector(pred)+qt(seq(0.5,0.999,0.001),df=56)*as.vector(sqrt(sigma2*(2+(t(x2)-t(x1))%*%solve(vcov(model.12))%*%(x2-x1))))

# plotting prediction interval "distribution"

plot(c(sort(lower),upper),c(seq(0.001,0.5,0.001),sort(seq(0.001,0.5,0.001),decreasing=TRUE)), xlab="Lower and upper limits for the prediction intervals", ylab="Confidence level", axes=FALSE)
axis(2, at=c(0,0.1,0.2,0.3,0.4,0.5),labels=c(100, 80, 60, 40, 20, 0))
axis(1, at=seq(-50,50,10))

# predictive hypothesis testing

T<-pred/sqrt(sigma2*(2+(t(x2)-t(x1))%*%solve(vcov(model.12))%*%(x2-x1)))

p<-2*pt(abs(T),df=56, lower.tail = FALSE)






















