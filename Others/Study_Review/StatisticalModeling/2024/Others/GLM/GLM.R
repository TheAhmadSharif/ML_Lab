setwd("/home/ahmad/Desktop/2023_2024/2024/StatisticalModeling/Datasets/")

# ??read.csv
# help(attach)
help(glm)
data = read.csv("tetrahymena.txt", sep = "\t", dec = ".", header = TRUE)
data

attach(data)

head(data)
unique(glucose)


glm_model = glm(diameter ~ conc + (factor(glucose)), data = data, family = gaussian(link = "log"))

summary(glm_model)

new_data = data.frame(conc = 80000, glucose = "yes")
predict(glm_model, newdata = new_data, type="response")

plot(conc, diameter, col= "blue")
points(conc, diameter, col= "blue")
points(conc[glucose=="yes"], diameter[glucose=="yes"], pch=19, col="red")
points(conc[glucose=="no"], diameter[glucose=="no"], pch=19, col="green")

lines(conc[glucose=="yes"], fitted(glm_model, type="response")[glucose=="yes"], col="red")
lines(conc[glucose=="no"], fitted(glm_model, type="response")[glucose=="no"], col="blue")


# ??predict

glm_exponential = glm(diameter ~ log(conc) + factor(glucose), data = data, family = gaussian(link = "log")) 
glm_exponential

plot(conc, diameter, col= "blue")
points(conc, diameter, col= "blue")
points(conc[glucose=="yes"], diameter[glucose=="yes"], pch=19, col="red")
points(conc[glucose=="no"], diameter[glucose=="no"], pch=19, col="green")
lines(conc[glucose=="yes"], fitted(glm_exponential, type="response")[glucose=="yes"], col="red")
lines(conc[glucose=="no"], fitted(glm_exponential, type="response")[glucose=="no"], col="blue")


new_data = data.frame(conc = 9000, glucose = "yes")
predict(glm_exponential, newdata = new_data, type="response")

mu_hat = predict(glm_exponential, newdata = new_data, type="response", interval = "confidence", level = 0.95)
mu_hat[1]
mu_hat[2]


fitted(glm_exponential,  type="response")
####################  3.6 ####################
data<-read.table("cysticfibrosis.txt", sep="\t", dec=".", header=TRUE)
data
head(data)

attach(data)

model = glm(pemax ~ log(height) + log(weight) + factor(sex), family = gaussian(link = "log"), data = data)

model

t = data[1,]
t
predict = predict(model, newdata = t, type = "response" )
predict
####################  3.2 ####################
### Example 3.2

data<-read.table("canoladiesel.txt", sep="\t", dec=".", header=TRUE)
attach(data)


head(data)


model = glm(Yield ~ Time, family = Gamma(link = "identity"), data = data)
model
