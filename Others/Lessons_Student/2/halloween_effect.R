# Read the data from the csv file
data <- read.csv("data.csv")

data$Date <- as.Date(data$Date, format = "%m/%d/%Y")


summer_model <- lm(Compounded_return ~ St_Dummy, data = subset(data, format(Date, "%m") %in% c("05", "06", "07", "08", "09", "10")))

winter_model <- lm(Compounded_return ~ St_Dummy, data = subset(data, !(format(Date, "%m") %in% c("05", "06", "07", "08", "09", "10"))))


summer_p_value <- get_p_value(summer_model)
winter_p_value <- get_p_value(winter_model)
