# https://www.youtube.com/watch?v=DD3PPwHy7VU
x1 <- c(45, 38, 52, 47, 45, 42, 43)
x2 <- c(39,44,50,54,48,46,40)
x3 <- c(50,46,43,48,57,44,48)
grand_sum <- sum(x1 + x2 + x3)
grand_x <- c(x1, x2, x3)
grand_mean <- grand_sum/21
grand_mean
sum_of_square_total <- sum((grand_x - grand_mean)^2)
sum_of_square_total
sum_of_square_within <- sum((x1 - mean(x1))^2) + sum((x2 - mean(x2))^2) + sum((x3 - mean(x3))^2)
sum_of_square_within
sum_of_square_between <- sum_of_square_total - sum_of_square_within
sum_of_square_between


# Step 04

mean_sum_of_square_between =  sum_of_square_between/2
mean_sum_of_square_between

mean_sum_of_square_within =  sum_of_square_within/18
mean_sum_of_square_within


F_Test_Statistic = mean_sum_of_square_between/mean_sum_of_square_within
F_Test_Statistic

# 0.91 < 3.55 (From F Table (2,18))
# Fail to reject null hypothesis