setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets/")

data = read.csv("satsuma.txt", sep = "\t", header = TRUE)
head(data)

help("lm")
attach(data)
x = Time
y = VitaminC
model = lm( VitaminC ~ Time, data = data )

new_data = data.frame(Time = c(4))
mu_hat = predict(model, newdata = new_data, interval = "confidence", level = 0.95)
mu_hat
??predict

summary(model)

plot(model)
plot(Time, VitaminC, type="n")
points(Time, VitaminC, type="n", pch=19)
lines(Time, fitted(model), lwd=12, col=blue)
lines(model)
coef(model)
# variance 
sigma(model)^2

##################################### 1.2 ##################################### 

data = read.csv("heliconia.txt", header = TRUE, sep="\t")
attach(data)  
head(data)
plot(data)


model = lm(length ~ (factor(variety)), data = data)
model
plot(model)

model_1 = lm (length ~ 1)
plot(model_1)


anova(model_1, model, test = "F")
plot(variety, length, type="n")
##################################### 1.3 ##################################### 


data = read.csv("blackcherry.txt", sep="\t", dec = ".", header = TRUE)
head(data)
attach(data)
y = Volume
x = Height + Girth 


model = lm( Volume ~ Girth + Height, data = data )
model
summary(model)

plot(Volume, Girth + Height)
points(Volume, Girth + Height)

help("abline")


plot(Girth, Volume)
plot(Height, Volume)
points(Girth, fitted(model), col="red", pch=19)

new.data<-data.frame(Girth=c(30), Height=c(22))
mu.hat<-predict(model, newdata=new.data, interval="confidence", level=0.95)
mu.hat

##################################### Assignments 1.2 ##################################### 

data = read.csv("teethpig.txt", header = TRUE, sep = "\t", dec=".")
head(data)
colnames(data)
attach(data)
model = lm(growth ~ dose + factor(level), data = data)
summary(model)

interaction.plot(level, dose, growth, mean)
plot(level, growth)

points(level[dose =="VC"], growth[dose=="VC"], col="red", pch=19)
points(level[dose =="OJ"], growth[dose=="OJ"], col="blue", pch=19)
unique(dose)
