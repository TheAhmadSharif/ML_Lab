# Data Structure

# Date: 16 October 2022 // Lokakuu // October

# Numeric
# Character/String
# Logical TRUE / FALSE
# Integer 1L

var_str <- "This is a string"
var_numeric <- 10.5
var_integer <- 2L
var_complex <- 9i + 3



# A vector is simply a list of items that are of the same type.


fruits_vector <- c("Banana", "Apple", "Orange")
numbers_vector <- c(1,4,9)



number_range_vector <- 1:10
decimal_range_vector <- 1.5:10.6
decimal_range_vector

log_values <- c(TRUE, FALSE, TRUE, FALSE)


# Vector Length
length(fruits_vector)
length(numbers_vector)


sort(number_range_vector)


fruits_vector[1]
fruits_vector[c(1, 3)]

# Change "banana" to "pear"
fruits_vector[1] <- "pear"


numbers <- seq(from = 0, to = 100, by = 20)
numbers
#  Lists  #

list_data <- list(1, 4, 5)
list_data
list_data[1]
length(list_data)

1 %in% list_data # Check 1 in the list
append(list_data, 8)
append(thislist, 12, after = 2) # Add "orange" to the list after "banana" (index 2):

for (x in list_data) {
  print(x)
}

## Join Two Lists

new_list <- list(15,16,20)
join_list <- c(list_data, new_list)



# Matrix : A matrix is a two dimensional data set with columns and rows. A column is a vertical representation of data, while a row is a horizontal representation of data.






thismatrix <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
thismatrix

# Concatenation
data_matrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)
data_matrix
data_matrix[1, 2]
data_matrix[2,]
data_matrix[,2]
data_matrix[c(1,2),]
data_matrix[, c(1,2)]

"apple" %in% data_matrix # Check Item in the matrix
dim(data_matrix)



# Data Structure

# Date: 16 October 2022 // Lokakuu // October

# Arrays : Compared to matrices, arrays can have more than two dimensions.


thisarray <- c(1:24)
thisarray


############## Data Frames ##############

Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)
Data_Frame
summary(Data_Frame)
Data_Frame[1]
Data_Frame[["Training"]]
Data_Frame$Training


# Add a new row
New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110))
New_row_DF
length(Data_Frame)

# Add a new column
New_col_DF <- cbind(Data_Frame, Steps = c(1000, 6000, 2000))
New_col_DF


############## Factors ##############
## Factors are used to categorize data. Examples of factors are:

# Demography: Male/Female
# Music: Rock, Pop, Classic, Jazz
# Training: Strength, Stamina

music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))
music_genre
levels(music_genre)
length(music_genre)
music_genre[3]
