install.packages("lme4", dependencies = TRUE)


# gfortran

fit.nb.col <- glm.nb(y ~ factor(color), data = Crabs)