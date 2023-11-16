# Graph
# Date: 16 October 2022 
# The plot() function is used to draw points (markers) in a diagram.



plot(2,4) # Allow two points only
plot(c(1,8), c(3,10))


x <- c(1, 2, 3, 4, 5)
y <- c(3, 7, 8, 9, 12)

print(x)
print(y)

plot(x, y)
plot(1:10)
plot(1:10, type="l", col="blue")

plot(1:10, type="l")

x <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y <- c(99,86,87,88,111,103,87,94,78,77,85,86)
plot(x, y, type="l", col="blue")



x2 <- c(2,2,8,1,15,8,12,9,7,3,11,4,7,14,12)
y2 <- c(100,105,84,105,90,99,90,95,94,100,79,112,91,80,85)

plot(x1, y1, main="Observation of Cars", xlab="Car age", ylab="Car speed", col="red", cex=2)
points(x2, y2, col="blue", cex=2)


# Pie Charts

# Create a vector of pies
x <- c(10,20,30,40)
mylabel <- c("Apples", "Bananas", "Cherries", "Dates")
pie(x, label = mylabel, main = "Fruits")

# Display the pie chart
pie(x)



# Bar Plot
x <- c(1,2,4,8)

barplot(y, names.arg = x)
