library(dplyr)
library(ggplot2)



filename <- 'olympics-economics.csv'
data <- read.csv(filename)

prize_type <- "Silver"  # This can be "Gold", "Silver", or "Bronze"
top_n_numbers <- 2    

column_name <- tolower(prize_type)

data <- data %>%
  mutate(total_medals = .[[column_name]])

# Sort the data by total medals and GDP in descending order
sorted_by_medals <- data %>% arrange(desc(total_medals))
sorted_by_gdp <- data %>% arrange(desc(gdp))

top_total_medals <- sorted_by_medals$total_medals
top_gdp <- sorted_by_medals$gdp
top_country_codes <- sorted_by_medals$country

# Combine into a new data frame for plotting
top_data <- data.frame(
  Total_Medals = top_total_medals,
  GDP = top_gdp,
  Country = paste(
    top_country_codes,
    ", Medals :: ", top_total_medals,
    ", GDP :: ", round(top_gdp, 2),
    sep = ""
  ),
  country_code = top_country_codes
)

# Mark top `top_n_numbers` based on medals and GDP for annotation
top_data <- top_data %>%
  mutate(
    Annotation = ifelse(
      row_number() <= top_n_numbers | country_code %in% sorted_by_gdp$country[1:top_n_numbers],
      Country,
      ""
    )
  )

# Create dynamic title
plot_title <- paste(prize_type, "vs GDP")

# Create the scatter plot for Total Medals vs GDP with specific annotations
plot <- ggplot(top_data, aes(x = Total_Medals, y = GDP)) +
  geom_point(size = 3, color = "blue") +    # Scatter plot points
  geom_text(aes(label = Annotation), vjust = -0.5, hjust = 0.5) +  # Add selected annotations
  labs(
    title = plot_title,    # Use dynamic title
    x = paste(prize_type),
    y = "GDP"
  ) +
  expand_limits(
    x = c(min(top_data$Total_Medals) - 50, max(top_data$Total_Medals) + 50),
    y = c(min(top_data$GDP) - 10000, max(top_data$GDP) + 10000)
  ) +    # Add padding
  theme_minimal() +
  theme(
    axis.line = element_line(color = "black", size = 1.2),   # Hard black axis lines
    axis.text = element_text(color = "black", size = 12),  # Red bold axis text
    axis.title = element_text(color = "black", size = 14), # Blue bold axis labels
    axis.ticks = element_line(color = "green", size = 1.2)   # Green axis ticks
  )

# Save the plot automatically to the "Report" folder
output_folder <- "Report"  # Define the folder name
if (!dir.exists(output_folder)) {
  dir.create(output_folder)  # Create the folder if it doesn't exist
}

output_file <- file.path(output_folder, paste0(prize_type, "_vs_GDP_plot.png"))


# Alternative: Save plot using png() if ggsave() fails
png(filename = output_file, width = 1000, height = 600)
print(plot)  # Print the ggplot object to the file
dev.off()  # Close the graphics device


print(paste("Plot saved to:", output_file))

