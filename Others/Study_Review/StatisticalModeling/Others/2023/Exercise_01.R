### Statistical Modeling 1 
### Linear Models
### 2022

############################
### Example 1.1
setwd("~/Desktop/tampere_sda/2022_2023/Semister_II/Statistical_Modeling/Datasets")
data<-read.table("paper.txt", sep="\t", dec=".", header=TRUE)

data
attach(data)

model <- lm(hardwood+pressure~pressure)
mode