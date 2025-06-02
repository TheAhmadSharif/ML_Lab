# Ahmad Sharif
# Student ID: K436765
# ahmad.sharif@tuni.fi
# Statistical Data Model DATA.STAT.740


setwd("/home/ahmad/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Exam_dataset")
install.packages("survival")
install.packages("eha")
library(eha)
library(survival)

# 1) a) 
data <- read.table("Melanooma.txt", sep="\t", dec=".", header = TRUE)
data
attach(data)
names(data)

main.model <- glm(status ~ sex+age+thickness+ulcer, family = binomial(link="logit"), data=data)
summary(main.model)
newdata <- data.frame(sex=1, age=50, thickness=7, ulcer=1)
mle_mu <- predict(main.model, newdata = newdata, type = "response")
mle_mu

# 0.6330488 

# 1) a) 
model.cox <- coxph(Surv(time, status)~sex+age+thickness+ulcer, data = data)
model.cox
sf.c <- survfit(model.c, newdata = newdata)
summary(sf.c, times=5000)

# Output
# time n.risk n.event survival std.err lower 95% CI upper 95% CI
# 5000      1      57    0.224  0.0803        0.111        0.452

# 0.224


# 1) c) 
library(eha)
model_weibull<-phreg(Surv(time, status)~sex+age+thickness+ulcer, data=data, dist="weibull")
model_weibull
model_weibull[6]
summary(model_weibull)

coef(model_weibull)
predictiton<-exp(coef(model_weibull)[6])
lambda<-exp(coef(model_weibull)[5])
beta<-coef(model_weibull)[1:4]
x<-t(t(c(1,50,7,1)))
lambda.star<-lambda/exp((t(x)%*%beta)/p)

qweibull(0.1, shape=p, scale=lambda.star) # 377.3103
qweibull(0.9, shape=p, scale=lambda.star) # 4823.555



# 2) a) 

data <- read.table("bcmort.txt", sep="\t", dec=".", header = TRUE)
data
attach(data)
names(data)
age <- data$age
cohort <- data$cohort
bcdeaths <- data$bcdeaths
pyr <- data$pyr
age






## a)

y<- bcdeaths/pyr
y



# 2.a
model.main<-glm(bcdeaths~offset(log(pyr))+age+factor(cohort), family=poisson(link="log"), data=data)
summary(model.main)

model.h <- glm(bcdeaths~offset(log(pyr))+age, family=poisson(link="log"), data=data)
summary(model.h)

anova(model.h, model.main, test = "Chi")
# Can not reject null hypothesis

newdata<-data.frame(age= "75-79", cohort="Study gr.", pyr= 25000)
pred<-predict(model.main, newdata=newdata, type="response")
pred # 25.55821 

#2.b)

#for the ratio estimate we have
ratio.estimate<-pred/newdata$pyr
ratio.estimate # 0.001022328 

# 2.c)

xf<-t(cbind(1,0,0,0,1,0,1))

Var.eYf<-pred*(1+pred*t(xf)%%vcov(model.main)%%xf)

lower.Yf<-pred-qnorm(0.9)*sqrt(Var.eYf)
upper.Yf<-pred+qnorm(0.9)*sqrt(Var.eYf)
lower.Yf
upper.Yf

Var.eZf<-((1/newdata$pyr)^2)*Var.eYf

lower.Zf<-ratio.estimate-qnorm(0.9)*sqrt(Var.eZf)
upper.Zf<-ratio.estimate+qnorm(0.9)*sqrt(Var.eZf)
lower.Zf # 0.0007450952
upper.Zf # 0.001299561




## 3) 

############################
### Question 2

data<-read.table("prostate.txt", sep="\t", dec=".", header=TRUE)
attach(data)
names(data)

age <- data$age
weight <- data$weight
cavol <- data$cavol
bph <- data$bph
cp <- data$cp
psa <- data$psa
## a)

plot(age,psa, type="n")
points(jitter(age[weight==0], 0.2), jitter(psa[weight==0], 0.2), col="blue", pch=19)
points(jitter(age[weight==1], 0.2), jitter(psa[weight==1], 0.2), col="red", pch=19)

interaction.plot(age, weight, psa)

normal.i<-glm(psa~factor(age)+factor(weight), family=gaussian(link="identity"), data=data)
summary(normal.i)
normal.l<-glm(psa~factor(age)+factor(weight), family=gaussian(link="log"), data=data)
summary(normal.l)
AIC(normal.i) # -5645.287
AIC(normal.l) # -5338.804

interaction.plot(age, weight, fitted(normal.i, type="response"))
interaction.plot(age, weight, fitted(normal.l, type="response"))

plot(fitted(normal.l, type="response"),residuals(normal.l, type="pearson"))

gamma.i<-glm(psa~factor(age)+factor(weight), family=Gamma(link="identity"), data=data)
gamma.l<-glm(psa~factor(age)+factor(weight), family=Gamma(link="log"), data=data)
AIC(gamma.i)
AIC(gamma.l)

plot(fitted(gamma.l, type="response"),residuals(gamma.l, type="pearson"))

ig.i<-glm(psa~factor(age)+factor(weight), family=inverse.gaussian(link="identity"), data=data)
ig.l<-glm(psa~factor(age)+factor(weight), family=inverse.gaussian(link="log"), data=data)
AIC(ig.i) #
AIC(ig.l) # -5538.138

plot(fitted(ig.l, type="response"),residuals(ig.l, type="pearson"))

o2<-residuals(normal.l, type="pearson")^2
mu<-fitted(normal.l, type="response")
pearson.n<-lm(o2~mu)
summary(pearson.n)

o2<-residuals(gamma.l, type="pearson")^2
mu<-fitted(gamma.l, type="response")
pearson.g<-lm(o2~mu)
summary(pearson.g)

o2<-residuals(ig.l, type="pearson")^2
mu<-fitted(ig.l, type="response")
pearson.ig<-lm(o2~mu)
summary(pearson.ig)

MSE.n<-mean(residuals(normal.l, type="response")^2)
MSE.g<-mean(residuals(gamma.l, type="response")^2)
MSE.ig<-mean(residuals(ig.l, type="response")^2)
MSE.n
MSE.g
MSE.ig
    
    