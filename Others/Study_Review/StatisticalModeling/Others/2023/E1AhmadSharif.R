### Statistical Modeling 1 
### Linear Models
### Ahmad Sharif
### Student ID: K436765
### ahmad.sharif@tuni.fi

############################
### Example 1.1
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
data<-read.table("paper.txt", sep="\t", dec=".", header=TRUE)

data
attach(data)
## a) 
model <- lm(hardwood+pressure~pressure)
summary(model)


fitted(model)
residuals(model)

## C) 
fitted(model)[36]
residuals(model)[36]

## d) 

