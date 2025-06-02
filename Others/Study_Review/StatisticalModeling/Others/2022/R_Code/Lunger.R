# 
# https://statslectures.com/r-scripts-datasets
# 
LungCapData <- read.table("LungCapData.txt", header = T, sep = "\t")
LungCapData


attach(LungCapData)

names(LungCapData)

class(Smoke)
class(Gender)

levels(Smoke)
Smoke
Gender


model <- lm(LungCap ~ Age + Smoke)
model
plot(LungCap, LungCap)
