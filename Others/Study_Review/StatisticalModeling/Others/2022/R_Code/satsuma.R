---
# 27 January 2023
# Satsuma Mandarin
  
  # Time == Day
  # Vitamin C = Left Vitamin

---
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
data<-read.table("satsuma.txt", sep="\t", dec=".", header=TRUE)

data
attach(data)

model <-lm(VitaminC~Time)

summary(model)

plot(Time, VitaminC, type="n")
points(Time, VitaminC, pch=19)
lines(Time, fitted(model), col="lightblue", lwd=3)
coef(model)
#####################################
# Heliconia is a genus of flowering plants in the monotypic family Heliconiaceae. 
#####################################
data<-read.table("heliconia.txt", sep="\t", dec=".", header=TRUE)
data
attach(data)
data
model<-lm(length~factor(variety))
model
summary(model)
model0<-lm(length~1)
model0
anova(model0, model, test="F") ## Null model, Alternative model0
plot(variety, length, type="p")
lines(variety, fitted(model), col="lightblue", lwd=3)
points(variety, fitted(model0), col="red", pch=15, cex=1.5)
lines(variety, fitted(model0), col="red", lwd=3)


data<-read.table("blackcherry.txt", sep="\t", dec=".", header=TRUE)
attach(data)
data


install.packages("rgl")
library(rgl)

plot3d(Girth, Height, Volume, type = "s", size = 0.75, lit = FALSE)
rgl.snapshot("Volume.png", fmt="png", top=TRUE )

plot(Girth, Volume)
plot(Height, Volume)


model<-lm(Volume~Girth+Height)
model
summary(model)
newdata<-expand.grid(Girth=seq(8,22,1), Height=seq(60,90,1))
head(newdata)
fit<-predict(model, newdata=newdata)
fit
fitted<-matrix(fit, nrow=length(seq(8,22,1)), ncol=length(seq(60,90,1)))
fitted
