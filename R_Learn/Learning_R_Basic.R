# This is a comment

# No R for multiline comments
plot(1:10)

# variable Declaration

name <- "Test"
age <- 30

name
age


# For Loop

for (x in 1:10) {
  print(x)
}

# Data Types


x <- 10.5
class(x)


x <- "This is a string"
class(x)

# integer
z <- 1000
class(z)

y <- TRUE
class(y)

max(5,4,6)
min(1,5,0)


sqrt(36)
abs(-9.6)


ceiling(1.4)
floor((1.4))


################################################
              # String #
################################################


var_str <- "This is a string"
print(var_str)

nchar(var_str) # String Length

str_1 <- "Hello"
str_2 <- "World"

paste(str_1, str_2, sep = " , ")


## End String ###


## Condition  ###
a <- 200
b <- 33

if (b > a) {
  print ("b is greater than a")
} else {
  print("b is not greater than a")
}

## Condition  ###



fruits <- list("Apple", "Banana", "Cherry")

for (x in fruits) {
  if (x == "Banana") {
    next
  }
  print(x)
}


## Function ###


my_function <- function(name) {
  paste("Hi", name)
}

my_function("Ahmad")
