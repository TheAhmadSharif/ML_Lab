## gg == Grammar of Graphics,

# install.packages("ggplot2", dependencies = TRUE, repos = "https://cran.r-project.org")
# aes Aesthetic Mapping

library("ggplot2")
help("ggplot2")

data(iris)
head(iris)
attach(iris)
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) +  geom_point(color = "blue")

