library(tidyverse)
library(dplyr)
library(highcharter)
library(lubridate)
library(stringr) 
library(purrr)
library(leaflet)
library(visdat)
library(naniar)
library(choroplethr)
library(choroplethrMaps)
library(htmlwidgets)
library(webshot)
library(devtools)
library(ggmap) 
library(RgoogleMaps) 
#library(maptools) 
#library(rgdal) 
library(ggplot2) 
#library(rgeos)
library(ggpubr)

airbnb <- read.csv("C:/Users/Ritwik Singh/OneDrive - University of Bath/Documents/Semester 2/Analytics in Practice/Coursework/listings.csv")
colnames(airbnb)

# First and last six entires of the data
head(airbnb)
tail(airbnb)

str(airbnb)
#Dealing with missing values
data <- (airbnb)
#Checking the total sum of missing values
sum(is.na(data))
sum(colSums(is.na(data)))
#Converting missing values to NA
data[data== ""] <- NA
data <- airbnb %>% select(name,price , neighbourhood_cleansed, review_scores_rating, property_type, number_of_reviews, review_scores_location, room_type , review_scores_value, minimum_nights)
sum(is.na(data))
View(data)
colnames(data)

51082 / 365400

# Renaming the selected columns
data <- data %>% rename(
  "Name" = name,
  "Price" = price,
  "Neighbourhood" = neighbourhood_cleansed,
  "Review Score Rating" = review_scores_rating,
  "Property Type" = property_type,
  "Number of Reviews" = number_of_reviews,
  "Location Score" = review_scores_location,
  "Room Type" = room_type,
  "Value for Money" = review_scores_value,
  "Minimum Nights" = minimum_nights
)
view(data)
colnames(data)

# Load required libraries
library(naniar)
library(ggplot2)
library(VIM)

# Visualization of missing values using vis_miss
vis_miss(data, warn_large_data = FALSE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 2, hjust = 1, size = 9)) +
  labs(title = "Missing Values by Variable") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 12))

# Convert Price from character to numeric
#data$Price <- as.numeric(gsub("[^0-9.]", "", data$Price))
# Assuming data is your data frame and Price is the column name
data$Price <- as.numeric(gsub("[£$,]", "", data$Price))


data$Price <- as.numeric(data$Price)

view(data$Price)
# Calculate the minimum value of the Price column
price_min <- min(data$Price, na.rm = TRUE)

# Calculate the maximum value of the Price column
price_max <- max(data$Price, na.rm = TRUE)

# Calculate the mean (average) of the Price column
price_mean <- mean(data$Price, na.rm = TRUE)

# Calculate the median of the Price column
price_median <- median(data$Price, na.rm = TRUE)

# Print the results
cat("Minimum Price:", price_min, "\n")
cat("Maximum Price:", price_max, "\n")
cat("Mean Price:", price_mean, "\n")
cat("Median Price:", price_median, "\n")

# Price distribution
ggplot(filtered_data, aes(x = Price)) +
  geom_histogram(binwidth = 20, fill = "#0073e6", color = "black") +  # Decreased binwidth
  labs(title = "Price Distribution across Amsterdam",
       x = "Price",
       y = "Number of Listings") +
  coord_cartesian(xlim = c(0, 30000)) +  # Adjust breaks on x-axis
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

# Calculate the interquartile range (IQR)
Q1 <- quantile(data$Price, 0.25, na.rm = TRUE)
Q3 <- quantile(data$Price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

# Define the lower and upper bounds for outliers
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR
lower_bound
upper_bound

# Filter the data to remove outliers
filtered_data <- data %>% filter(Price >= lower_bound & Price <= upper_bound)

# Now, calculate the statistics again for the filtered data
price_min <- min(filtered_data$Price, na.rm = TRUE)
price_max <- max(filtered_data$Price, na.rm = TRUE)
price_mean <- mean(filtered_data$Price, na.rm = TRUE)
price_median <- median(filtered_data$Price, na.rm = TRUE)

# Print the results
cat("Minimum Price:", price_min, "\n")
cat("Maximum Price:", price_max, "\n")
cat("Mean Price:", price_mean, "\n")
cat("Median Price:", price_median, "\n")


## Create a histogram with decreased binwidth and adjusted x-axis breaks
ggplot(filtered_data, aes(x = Price)) +
  geom_histogram(binwidth = 20, fill = "#0073e6", color = "black") +  # Decreased binwidth
  labs(title = "Price Distribution across Amsterdam",
       x = "Price",
       y = "Number of Listings") +
  coord_cartesian(xlim = c(0, 1000)) +  # Set x-axis limits
  scale_x_continuous(breaks = seq(0, 1000, by = 50)) +  # Adjust breaks on x-axis
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))


# Convert Price to numeric if it's not already
data$Price <- as.numeric(data$Price)

# Create a histogram
ggplot(data, aes(x = Price)) +
  geom_histogram(binwidth = 20, fill = "#0073e6", color = "black") +
  labs(title = "Distribution of Listing Prices",
       x = "Price",
       y = "Number of Listings") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

typeof(data$Price)

# Filter the data for listings with price between €0 and €50
listings_0_to_50 <- filtered_data$Price >= 0 & filtered_data$Price <= 50

# Count the number of listings within the specified price range
num_listings_0_to_50 <- sum(listings_0_to_50)

# Print the result
cat("The number of listings in the range from €0 to €50:", num_listings_0_to_50, "\n")

# Calculate the percentage
percentage_0_to_50 <- (num_listings_0_to_50 / nrow(filtered_data)) * 100

# Print the result
cat("The percentage of listings in the range from €0 to €50 out of total listings:", percentage_0_to_50, "%\n")

# Calculate room type counts
room_counts <- table(filtered_data$`Room Type`)

# Convert to data frame
room_counts_df <- as.data.frame(room_counts)
names(room_counts_df) <- c("Room_Type", "Count")

# Calculate percentage
room_counts_df$Percentage <- room_counts_df$Count / sum(room_counts_df$Count) * 100


# Calculate the position for text labels dynamically
room_counts_df <- room_counts_df %>%
  arrange(desc(Percentage)) %>%
  mutate(label_y = max(room_counts_df$Percentage) / 2)  # Set y position for text labels

# Check unique values in the 'neighbourhood_cleansed' column
unique_neighborhoods <- unique(airbnb$neighbourhood_cleansed)
print(unique_neighborhoods)

# Neighborhood Counts
neighborhood_counts <- table(airbnb$neighbourhood_cleansed)

# Convert to data frame
neighborhood_counts_df <- as.data.frame(neighborhood_counts)
names(neighborhood_counts_df) <- c("Neighbourhood_Cleansed", "Listing_Count")

neighborhood_counts_df <- neighborhood_counts_df %>%
  arrange(Listing_Count) %>%
  mutate(label_y = Listing_Count + 5)  # Adjust the vertical position of the labels

# Visualization
# Create a bar plot
ggplot(neighborhood_counts_df, aes(x = reorder(Neighbourhood_Cleansed, Listing_Count), y = Listing_Count)) +
  geom_bar(stat = "identity", fill = "#0073e6", color = "black") +  # Add color for borders
  geom_text(aes(label = Listing_Count), size = 3, hjust = -0.3, color = "black", fontface = "bold") +  # Make numbers bold
  labs(title = "Number of Airbnb Listings by Neighbourhood in Amsterdam",
       x = "Neighbourhood",
       y = "Number of Listings") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()  # Flip x and y axes for better readability if there are many neighborhoods


# Calculate average location rating per neighborhood
avg_rating_per_neighborhood <- data %>%
  group_by(Neighbourhood) %>%
  summarize(avg_rating = mean(`Location Score`, na.rm = TRUE)) %>%
  arrange(desc(avg_rating))  # Sort by average rating from highest to lowest

# Reorder the levels of Neighbourhood in descending order of average rating
avg_rating_per_neighborhood$Neighbourhood <- factor(avg_rating_per_neighborhood$Neighbourhood,
                                                levels = avg_rating_per_neighborhood$Neighbourhood[order(avg_rating_per_neighborhood$avg_rating, decreasing = TRUE)])

view(avg_rating_per_neighborhood)
# Plotting
ggplot(avg_rating_per_neighborhood, aes(x = Neighbourhood, y = avg_rating, group = 1)) +
  geom_line(color = "#0073e6") +  # Add a line connecting the data points
  geom_point(color = "#0073e6", size = 2) +  # Add points for each data point
  geom_text(aes(label = sprintf("%.2f", avg_rating)), size = 3.5, fontface = "bold", vjust = -0.5) +  # Add ratings on top of points with two decimal places in bold
  labs(title = "Average Location Ratings by Neighbourhood in Amsterdam",
       x = "Neighbourhood",
       y = "Average Rating") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(angle = 50, hjust = 1))

colnames(data)
library(dplyr)

# Count the frequency of each neighborhood
neighborhood_freq <- data %>% 
  count(Neighbourhood)

# Check if both dataframes exist
if (!exists("avg_rating_per_neighborhood")) {
  print("DataFrame 'avg_rating_per_neighborhood' does not exist.")
} else if (!exists("neighborhood_freq")) {
  print("DataFrame 'neighborhood_freq' does not exist.")
} else {
  # Check column names of both dataframes
  if (!"Neighbourhood" %in% colnames(avg_rating_per_neighborhood)) {
    print("Column 'Neighbourhood' not found in 'avg_rating_per_neighborhood'.")
  } else if (!"Neighbourhood_Cleansed" %in% colnames(neighborhood_freq)) {
    print("Column 'Neighbourhood_Cleansed' not found in 'neighborhood_freq'.")
  } else {
    # Merge the two dataframes
    avg_rating_per_neighborhood <- merge(avg_rating_per_neighborhood, neighborhood_freq, 
                                          by.x = "Neighbourhood", by.y = "Neighbourhood_Cleansed", 
                                          all.x = TRUE)
    print("Merged successfully.")
  }
}
if (exists("avg_rating_per_neighborhood")) {
  print("DataFrame 'avg_rating_per_neighborhood' exists.")
} else {
  print("DataFrame 'avg_rating_per_neighborhood' does not exist.")
}
#rm(avg_ratings_per_neighbourhood)
# Create a new dataframe named avg_ratings_per_neighbourhood
#avg_rating_per_neighborhood <- data.frame(
 # Neighbourhood = character(),  # Neighbourhood names will be stored here
  #avg_rating = numeric(),        # Average ratings will be stored here
  #stringsAsFactors = FALSE      # Avoid converting strings to factors
#)



# Merge the two dataframes
avg_rating_per_neighborhood <- merge(avg_rating_per_neighborhood, neighborhood_freq, 
                                     by = "Neighbourhood", all.x = TRUE)

# Check if the merge was successful
if ("n" %in% colnames(avg_rating_per_neighborhood)) {
  print("Merge successful.")
} else {
  print("Merge unsuccessful.")
}


# Reorder the neighbourhoods by average rating
avg_rating_per_neighborhood <- avg_rating_per_neighborhood[order(avg_rating_per_neighborhood$avg_rating, decreasing = TRUE),]

# Plotting




library(dplyr)

# Calculate the number of listings per neighborhood
avg_rating_per_neighborhood <- avg_rating_per_neighborhood %>%
  group_by(Neighbourhood) %>%
  summarize(n = n())  # Count the number of rows in each group

# # Plotting
# ggplot(avg_rating_per_neighborhood, aes(x = reorder(Neighbourhood, avg_rating), y = n)) +
#   geom_bar(stat = "identity", fill = "#0073e6") +
#   labs(title = "Number of Airbnb Listings by Neighbourhood in Amsterdam",
#        x = "Neighbourhood",
#        y = "Number of Listings") +
#   theme(plot.title = element_text(hjust = 0.5, face = "bold"),
#         axis.text.x = element_text(angle = 45, hjust = 1))



# library(ggplot2)
# 
# # Reorder the neighbourhoods by average rating
# avg_rating_per_neighborhood <- avg_rating_per_neighborhood[order(avg_rating_per_neighborhood$avg_rating, decreasing = TRUE),]
# 
# Plotting
ggplot(avg_rating_per_neighborhood, aes(x = reorder(Neighbourhood, -avg_rating), y = n, group = 1)) +
  geom_line(color = "#0073e6") +  # Add a line connecting the data points
  geom_point(color = "#0073e6", size = 2) +  # Add points for each data point
  geom_text(aes(label = n), vjust = -0.5, size = 3, color = "black", fontface = "bold") +  # Add labels on top of points with bold font
  labs(title = "Number of Airbnb Listings by Neighbourhood in Amsterdam (Rating Highest to Lowest)",
       x = "Neighbourhood",
       y = "Number of Listings") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(angle = 50, hjust = 1))

print(avg_rating_per_neighborhood)


library(ggplot2)

# Reorder the neighbourhoods by average rating
avg_rating_per_neighborhood <- avg_rating_per_neighborhood[order(avg_rating_per_neighborhood$avg_rating, decreasing = TRUE),]

# Plotting
ggplot(avg_rating_per_neighborhood, aes(x = reorder(Neighbourhood, -avg_rating), y = avg_rating, group = 1)) +
  geom_line(color = "#0073e6") +  # Add a line connecting the data points
  geom_point(color = "#0073e6", size = 2) +  # Add points for each data point
  geom_text(aes(label = avg_rating), vjust = -0.5, size = 3, color = "black", fontface = "bold") +  # Add labels on top of points with bold font
  labs(title = "Average Rating by Neighbourhood in Amsterdam (Rating Highest to Lowest)",
       x = "Neighbourhood",
       y = "Average Rating") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(angle = 50, hjust = 1))




library(dplyr)

# Group the data by Neighbourhood and calculate the average price
average_price_per_neighbourhood <- data %>%
  group_by(Neighbourhood) %>%
  summarize(Avg_Price = mean(Price, na.rm = TRUE))

# View the resulting data frame
print(average_price_per_neighbourhood)



# Load the ggplot2 library
library(ggplot2)

# Plot the average price per neighbourhood using a bar graph with transposed axes
# Plot the average price per neighbourhood using a bar graph with transposed axes
ggplot(average_price_per_neighbourhood, aes(x = Avg_Price, y = reorder(Neighbourhood, Avg_Price))) +
  geom_bar(stat = "identity", fill = "#0073e6") +  # Create a horizontal bar plot
  geom_text(aes(label = sprintf("%.1f", Avg_Price)), hjust = -0.1, size = 3.5, fontface = "bold") +  # Add values at the end of every bar with one decimal place in bold
  labs(title = "Average Accommodation Price by Neighbourhood",  # Add title
       x = "Average Price",
       y = "Neighbourhood") +  # Add labels for title and axes
  theme(plot.title = element_text(face = "bold", hjust = 0.5),  # Center-aligned and bold title
        axis.text.y = element_text(hjust = 1))  # Adjust y-axis labels alignment for better readability





# colnames(data)
# # Find distinct values in the Property Type column
# distinct_property_types <- unique(property_types)
# 
# 
# 
# 
# 
# # Initialize empty lists for each category
# apartments <- character(0)
# house <- character(0)
# bed_and_breakfast <- character(0)
# houseboat <- character(0)
# 
# # Iterate over each property type and assign it to the appropriate category
# for (property_type in distinct_property_types) {
#   if (grepl("apartment|condo|loft|townhouse|serviced apartment", tolower(property_type))) {
#     apartments <- c(apartments, property_type)
#   } else if (grepl("home|villa|cottage|cabin|chalet|farm stay|vacation home", tolower(property_type))) {
#     house <- c(house, property_type)
#   } else if (grepl("bed and breakfast|casa particular", tolower(property_type))) {
#     bed_and_breakfast <- c(bed_and_breakfast, property_type)
#   } else if (grepl("houseboat", tolower(property_type))) {
#     houseboat <- c(houseboat, property_type)
#   }
# }
# 
# # Print the segregated property types
# cat("Apartments:", apartments, "\n")
# cat("House:", house, "\n")
# cat("Bed and Breakfast:", bed_and_breakfast, "\n")
# cat("Houseboat:", houseboat, "\n")
# 
# 
# apartments_count <- 0
# house_count <- 0
# bed_and_breakfast_count <- 0
# houseboat_count <- 0
# 
# # Iterate over each property type and count the frequency for each category
# for (property_type in distinct_property_types) {
#   if (grepl("apartment|condo|loft|townhouse|serviced apartment", tolower(property_type))) {
#     apartments_count <- apartments_count + 1
#   } else if (grepl("home|villa|cottage|cabin|chalet|farm stay|vacation home", tolower(property_type))) {
#     house_count <- house_count + 1
#   } else if (grepl("bed and breakfast|casa particular", tolower(property_type))) {
#     bed_and_breakfast_count <- bed_and_breakfast_count + 1
#   } else if (grepl("houseboat", tolower(property_type))) {
#     houseboat_count <- houseboat_count + 1
#   }
# }
# 
# # Create a data frame for the frequencies
# property_counts <- data.frame(
#   Category = c("Apartments", "House", "Bed and Breakfast", "Houseboat"),
#   Frequency = c(apartments_count, house_count, bed_and_breakfast_count, houseboat_count)
# )
# 
# # Plot the line graph
# library(ggplot2)
# 
# ggplot(property_counts, aes(x = Category, y = Frequency, group = 1)) +
#   geom_line() +
#   geom_point() +
#   labs(title = "Frequency of Property Types",
#        x = "Category",
#        y = "Frequency")




# Assuming your data frame is named 'df' and the column containing room types is named 'Room Type'
room_type_counts <- table(data$`Room Type`)

# View the frequency of each room type
print(room_type_counts)



# Plotting the distribution of room types
barplot(room_type_counts, main = "Distribution of Room Types", xlab = "Room Type", ylab = "Frequency")



# 1. Compare Room Type Distribution Across Different Locations
location_room_counts <- table(data$neighbourhood_cleansed, data$room_type)
location_room_counts <- as.data.frame.matrix(location_room_counts)


names(data)





# Aggregate the data to get counts of each room type in each location
location_room_counts <- data %>%
  group_by(Neighbourhood, `Room Type`) %>%
  summarise(count = n()) %>%
  ungroup()

# Plotting
ggplot(location_room_counts, aes(x = Neighbourhood, y = count, fill = `Room Type`)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(x = "Neighbourhood", y = "Frequency", fill = "Room Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Room Type Distribution Across Different Neighbourhoods")



# Aggregate the data to get counts of each room type in each location
location_room_counts <- data %>%
  group_by(Neighbourhood, `Room Type`) %>%
  summarise(count = n()) %>%
  ungroup()

# Plotting
# Plotting with different shapes for each room type
ggplot(location_room_counts, aes(x = Neighbourhood, y = count, color = `Room Type`, shape = `Room Type`, group = `Room Type`)) +
  geom_line() +
  geom_point() +  # Add points
  labs(x = "Neighbourhood", y = "Frequency", color = "Room Type", shape = "Room Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Trends of Room Types Across Different Neighbourhoods")

colnames(data)

# Assuming you have a column named "Price" in your original dataset

# Calculate price per night
data <- data %>%
  mutate(Price_Per_Night = Price / `Minimum Nights`)

# Aggregate the data to get average price per night for each room type in each neighborhood
location_room_counts <- data %>%
  group_by(Neighbourhood, `Room Type`) %>%
  summarise(count = n(), Average_Price_Per_Night = mean(Price_Per_Night)) %>%
  ungroup()


ggplot(location_room_counts, aes(x = Neighbourhood, y = Average_Price_Per_Night, color = `Room Type`, group = `Room Type`, shape = `Room Type`)) +
  geom_line() +
  geom_point() +
  labs(x = "Neighbourhood", y = "Average Price Per Night", color = "Room Type", shape = "Room Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Average Price Per Night for Each Room Type in Each Neighbourhood")







# Filter out rows with NA values in Average_Price_Per_Night column
location_room_counts <- location_room_counts[!is.na(location_room_counts$Average_Price_Per_Night), ]

# Plot the data
ggplot(location_room_counts, aes(x = Neighbourhood, y = Average_Price_Per_Night, color = `Room Type`, group = `Room Type`, shape = `Room Type`)) +
  geom_line() +
  geom_point() +
  labs(x = "Neighbourhood", y = "Average Price Per Night", color = "Room Type", shape = "Room Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Average Price Per Night for Each Room Type in Each Neighbourhood")


# data$Price_Per_Night
# 
# # Filter the data for price less than 50
# filtered_data <- data[data$Price < 50, ]
# 
# # Display unique combinations of Room Type and Neighbourhood Cleansed
# unique_room_neighbourhood <- unique(filtered_data[, c("Room Type", "Neighbourhood Cleansed")])
# print(unique_room_neighbourhood)
# 
# 
# # Check column names in filtered_data
# colnames(filtered_data)
# 
# 
# # Display unique combinations of Room Type and Neighbourhood Cleansed with price less than 50
# unique_room_neighbourhood <- unique(filtered_data[, c("Room Type", "Neighbourhood")][filtered_data$Price < 50, ])
# 
# 
# ggplot(unique_room_neighbourhood, aes(x = Neighbourhood, color = `Room Type`, group = `Room Type`)) +
#   geom_line(stat = "count") +
#   labs(x = "Neighbourhood", y = "Frequency", color = "Room Type") +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   ggtitle("Unique Room Types with Price Less Than 50 in Each Neighbourhood")

# unique(data$`Property Type`)
# 
# filtered_data <- data[data$Price < 50, ]
# 
# # Plotting the frequency of room types with prices under 50 in each location
# ggplot(filtered_data, aes(x = Neighbourhood, color = `Room Type`, group = `Room Type`)) +
#   geom_line(stat = "count") +
#   labs(x = "Neighbourhood", y = "Frequency", color = "Room Type") +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   ggtitle("Room Types with Price Less Than 50 in Each Neighbourhood")


# Load required libraries
library(dplyr)
library(ggplot2)

# Define function to categorize property types
categorize_property_type <- function(property_type) {
  if (grepl("hostel|bed and breakfast", property_type, ignore.case = TRUE)) {
    return("Hostel/bed and Breakfast")
  } else if (grepl("condo|loft", property_type, ignore.case = TRUE)) {
    return("Condo/Loft")
  } else if (grepl("apartment", property_type, ignore.case = TRUE)) {
    return("Apartment")
  } else if (grepl("rental unit", property_type, ignore.case = TRUE)) {
    return("Rental Unit")
  } else if (grepl("home|house|villa|townhouse|casa", property_type, ignore.case = TRUE)) {
    return("House")
  } else if (grepl("hotel|aparthotel", property_type, ignore.case = TRUE)) {
    return("Hotel/Aparthotel")
  } else if (grepl("boat|houseboat", property_type, ignore.case = TRUE)) {
    return("Boat/Houseboat")
  } else {
    return("Other")
  }
}

# Apply the function to categorize property types
data <- data %>%
  mutate(Property_Category = sapply(`Property Type`, categorize_property_type))

# Define function to categorize room types
categorize_room_type <- function(room_type) {
  if (grepl("entire home/apt", room_type, ignore.case = TRUE)) {
    return("Entire home/apt")
  } else if (grepl("private room", room_type, ignore.case = TRUE)) {
    return("Private room")
  } else if (grepl("shared room", room_type, ignore.case = TRUE)) {
    return("Shared room")
  } else if (grepl("hotel room", room_type, ignore.case = TRUE)) {
    return("Hotel room")
  } else {
    return("Other")
  }
}

# Apply the function to categorize room types
data <- data %>%
  mutate(Room_Category = sapply(`Room Type`, categorize_room_type))

# Reorder Property_Category levels
data$Property_Category <- factor(data$Property_Category, levels = c("Rental Unit", "Apartment", "House", "Hotel/Aparthotel", "Hostel/bed and Breakfast", "Condo/Loft", "Boat/Houseboat", "Other"))

# Calculate frequency of each property type within each room type category
room_category_counts <- data %>%
  count(Room_Category, Property_Category) %>%
  filter(Room_Category %in% c("Entire home/apt", "Private room", "Shared room", "Hotel room"))  # Include Hotel room category

# Calculate the average price for each room type
average_price_room <- data %>%
  group_by(Property_Category, Room_Category) %>%
  summarise(Average_Price = mean(Price, na.rm = TRUE))  # Adding na.rm = TRUE to handle any missing prices

# Define colors for each room type
room_colors <- c("Entire home/apt" = "red", "Private room" = "blue", "Shared room" = "green", "Hotel room" = "orange")

# Plot bar graph for average price of each room type
bar_plot_line <- ggplot(average_price_room, aes(x = Property_Category, y = Average_Price, fill = Room_Category)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", size = 0.5) + # Add border around bars
  geom_text(data = average_price_room, aes(x = Property_Category, y = Average_Price, label = round(Average_Price, 2)), size = 3, color = "black", fontface = "bold", position = position_dodge(width = 0.9), vjust = -0.5) +  # Adjust position_dodge to align labels with dodged bars and vjust to move the labels above the bars
  labs(x = "Property Category", y = "Average Price", fill = "Room Type") +
  theme_minimal() +
  ggtitle("Average Price of Each Room Type") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.key = element_rect(color = "black", size = 0.5), # Add border around legend
        plot.title = element_text(face = "bold", hjust = 0.5, colour = "black", size = 14),
        legend.background = element_rect(color = "black", size = 0.5)) # Add border around legend box

bar_plot_line

# Plot bar graph for frequency of each room type
bar_plot_frequency <- ggplot(room_category_counts, aes(x = Property_Category, y = n, fill = Room_Category)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", size = 0.5) + # Add border around bars
  geom_text(data = room_category_counts, aes(x = Property_Category, y = n, label = n), size = 3, color = "black", fontface = "bold", position = position_dodge(width = 0.9), vjust = -0.5) +  # Adjust position_dodge to align labels with dodged bars and vjust to move the labels above the bars
  labs(x = "Property Category", y = "Frequency", fill = "Room Type") +
  theme_minimal() +
  ggtitle("Frequency of Property Categories by Room Type") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.key = element_rect(color = "black", size = 0.5), # Add border around legend
        plot.title = element_text(face = "bold", hjust = 0.5, colour = "black", size = 14),
        legend.background = element_rect(color = "black", size = 0.5)) # Add border around legend box

# Display the bar plot for frequency of each room type
bar_plot_frequency



# Load required libraries
library(ggplot2)

property_category_counts <- data %>%
  count(Property_Category)

# Create bar plot
bar_plot_property <- ggplot(property_category_counts, aes(x = Property_Category, y = n)) +
  geom_bar(stat = "identity", fill = "#0073e6", color = "black") +
  geom_text(aes(label = n), vjust = -0.5, size = 4, fontface = "bold") +  # Add text on top of bars
  labs(title = "Frequency of Property Category Types", x = "Property Category", y = "Number of Listings") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8),  # Adjust size of x-axis labels
        plot.title = element_text(hjust = 0.5, face = "bold"))

# Display the bar plot
bar_plot_property


# Apply categorization function to create a new column 'Property_Category'
data <- data %>%
  mutate(Property_Category = sapply(`Property Type`, categorize_property_type))

# Count the frequency of each Property Category for each Neighborhood
property_category_counts <- data %>%
  count(Neighbourhood, Property_Category) %>%
  arrange(Neighbourhood, desc(n))

# Define custom pastel color palette
pastel_palette <- c("#FFD1DC", "#FFB6C1", "#FFA07A", "#FFD700", "#98FB98", "#ADD8E6", "#87CEEB", "#C6E2FF", "#F0E68C", "#D3D3D3", "#FFA07A", "#F08080", "#20B2AA", "#FF6347", "#E0FFFF", "#F0FFF0", "#FFE4E1", "#FFF0F5", "#E6E6FA", "#FFFACD")

transposed_single_stacked_bar_plot_pastel <- ggplot(property_category_counts, aes(x = n, y = Neighbourhood, fill = Property_Category)) +
  geom_bar(stat = "identity", width = 0.7) +
  labs(title = "Frequency of Property Category Types by Neighbourhood",
       x = "Number of Listings",
       y = "Neighbourhood") +
  scale_fill_manual(values = pastel_palette) +  # Use pastel color palette
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0),  # Adjust angle of y-axis labels
        plot.title = element_text(hjust = 0.5, face = "bold"))

# Display the transposed single vertical stacked bar plot with pastel colors
transposed_single_stacked_bar_plot_pastel















# Calculate total number of listings in each city
total_listings <- property_category_counts %>%
  group_by(Neighbourhood) %>%
  summarise(total_listings = sum(n))

# Create transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel <- ggplot(property_category_counts, aes(x = n, y = Neighbourhood)) +
  geom_bar(aes(fill = Property_Category), stat = "identity", width = 0.7, color = "black") +
  labs(title = "Frequency of Property Category Types by Neighbourhood",
       x = "Number of Listings",
       y = "Neighbourhood") +
  scale_fill_manual(values = pastel_palette) +  # Use pastel color palette
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0),  # Adjust angle of y-axis labels
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  geom_text(data = total_listings, aes(x = total_listings + 10, y = Neighbourhood, label = total_listings, fontface = "bold"))

# Display the transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel

















# Reorder levels of Neighbourhood based on total number of listings
total_listings <- property_category_counts %>%
  group_by(Neighbourhood) %>%
  summarise(total_listings = sum(n)) %>%
  arrange(desc(total_listings))

property_category_counts$Neighbourhood <- factor(property_category_counts$Neighbourhood, levels = total_listings$Neighbourhood)

# Create transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel <- ggplot(property_category_counts, aes(x = n, y = Neighbourhood)) +
  geom_bar(aes(fill = Property_Category), stat = "identity", width = 0.7, color = "black") +
  labs(title = "Frequency of Property Category Types by Neighbourhood",
       x = "Number of Listings",
       y = "Neighbourhood") +
  scale_fill_manual(values = differentiated_palette) +  # Use pastel color palette
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0),  # Adjust angle of y-axis labels
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  geom_text(data = total_listings, aes(x = total_listings + 40, y = Neighbourhood, label = total_listings, fontface = "bold"))

# Display the transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel




view(Property_Category)

view(property_category_counts)






# Calculate total number of listings for each property type
total_listings_per_type <- property_category_counts %>%
  group_by(Property_Category) %>%
  summarise(total_listings = sum(n))
differentiated_palette <- c("#FFD1DC", "#FF7F50", "#FFA07A", "#FFD700", "#32CD32", "#6495ED", "#87CEEB", "#9370DB", "#FF69B4", "#20B2AA", "#FFA500", "#6A5ACD", "#00BFFF", "#8A2BE2", "#F08080", "#FF6347", "#D8BFD8", "#FFFACD", "#B0C4DE", "#F0E68C")

# Create transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel <- ggplot(property_category_counts, aes(x = n, y = Neighbourhood, fill = Property_Category)) +
  geom_bar(stat = "identity", width = 0.7, color = "black") +
  labs(title = "Frequency of Property Category Types by Neighbourhood",
       x = "Number of Listings",
       y = "Neighbourhood") +
  scale_fill_manual(values = differentiated_palette, name = "Property Type", 
                    labels = paste(total_listings_per_type$Property_Category, 
                                   "\n(", total_listings_per_type$total_listings, ")", sep = "")) +  # Custom legend labels
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0),  # Adjust angle of y-axis labels
        plot.title = element_text(hjust = 0.5, face = "bold"))

# Display the transposed single vertical stacked bar plot with pastel colors, black borders, and total counts
transposed_single_stacked_bar_plot_pastel






