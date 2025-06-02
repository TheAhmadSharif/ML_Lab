## https://www.tutorialspoint.com/r/r_data_frames.htm
## Data Frame
emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25))
emp.data


df <- data.frame(
  "id" = c(1:4),
  "name" = c("Tampere", "Kangasala", "Nokia", "Lempaala")
)
print(df)
df$id


v <- 2+5i
v
list1 <- list(c(2,5,3),21.3,sin)
list1
