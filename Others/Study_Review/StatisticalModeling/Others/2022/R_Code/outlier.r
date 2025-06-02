w <- c(5,64,66,68,70)
quantile(w)
boxplot(w, col = "orange", xlab="Weight")


############## Simulation ############## 

p = 0.5
U = runif(1, min = 0, max = 1)
X = (U < p)
X


############## Z-Score ############## 

# https://www.youtube.com/watch?v=q5hdtU5UH5Y

school_a <- c(72,74,78,80)
school_b <- c(84,76,82,72)

# Calculate mean
mean(school_a)

# Calculate standard deviation
sd(school_a)

# calculate z-score
zscore <- (school_a - mean(school_a)) / sd(school_a)
zscore


get_z_score <- function(data) {
  z_score <- (data - mean(data)) / sd(data)
  print(z_score)
}



get_z_score(school_a)

plot(get_z_score(school_a), type="o", col="blue")
plot(get_z_score(school_b), type="o", col="red")
