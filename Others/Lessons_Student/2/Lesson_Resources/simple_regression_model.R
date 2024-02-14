study_hour = c(1, 2, 3, 4)
test_score = c(8, 12, 18, 22)


model = lm( test_score ~ study_hour)
summary(model)