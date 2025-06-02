packages <- c("survival")
install.packages(setdiff(packages, rownames(installed.packages())), repos="http://cran.us.r-project.org", dependencies = TRUE)
library("survival")
setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets")
help("survival")
help(package="survival")
# data<-read.table("lung_cancer.csv", sep="\t", dec=",", header=TRUE)
attach(lung)
head(lung)

# status 1 = Person Alive
# status 2 = Person Died

# inst:	Institution code
# time:	Survival time in days
# status:	censoring status 1=censored, 2=dead
# age:	Age in years
# sex:	Male=1 Female=2
# ph.ecog:	ECOG performance score as rated by the physician. 0=asymptomatic, 1= symptomatic but completely ambulatory, 2= in bed <50% of the day, 3= in bed > 50% of the day but not bedbound, 4 = bedbound
# ph.karno:	Karnofsky performance score (bad=0-good=100) rated by physician
# pat.karno:	Karnofsky performance score as rated by patient
# meal.cal:	Calories consumed at meals
# wt.loss:	Weight loss in last six months (pounds)
# help(package="survival")

help("lm")
help(package="survival")
# y ~ x
plot(age, time, col="blue", cex=0.2)

Surv(time, status)




model<-coxph(Surv(time, status)~age, data=lung)
summary(model) 



model = coxph(Surv(time, status) ~ age, data=lung)
summary(model)



newdata = data.frame(age=c(70))  

sf = survfit(model, newdata=newdata)
summary(sf, times=800)

plot(sf)
