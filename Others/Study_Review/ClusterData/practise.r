############ 12 October 2024 ############ 

install.packages("boot")
install.packages("geepack")



library(boot)
library(geepack)
# Install ggplot2 if not already installed
# install.packages("ggplot2")
library(ggplot2)
library(geepack)  # For GEE
library(lme4)


nitrofen


# Example data setup
# Assuming 'live' refers to surviving broods or successful offspring
data <- nitrofen



library(geepack)
library(boot)


data(nitrofen)
str(nitrofen)


data(nitrofen)
str(nitrofen)


library(geepack)

model <- gee(total ~ conc, id = 1:nrow(nitrofen), data = nitrofen, family = gaussian, corstr = "exchangeable")
summary(model)

model <- gee(y ~ x1 + x2, id = id_variable, data = nitrofen, family = gaussian, corstr = "exchangeable")
summary(model)


# View the column names and the first few rows of the dataset
colnames(data)
head(data)

# Reshape data into long format for easier plotting
library(tidyr)
long_data <- data %>%
  gather(key = "brood_type", value = "brood_count", brood1, brood2, brood3)

# View the reshaped data
head(long_data)


######################### 
ggplot(long_data, aes(x = as.factor(conc), y = brood_count, fill = brood_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Concentration", y = "Brood Count", title = "Brood Counts by Group and Concentration") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "red", "green")) +
  theme(legend.title = element_blank())



################


# Line plot showing brood counts across concentrations
ggplot(long_data, aes(x = as.factor(conc), y = brood_count, color = brood_type, group = brood_type)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  labs(x = "Concentration", y = "Brood Count", title = "Brood Counts by Group and Concentration") +
  theme_minimal() +
  scale_color_manual(values = c("blue", "red", "green"))
