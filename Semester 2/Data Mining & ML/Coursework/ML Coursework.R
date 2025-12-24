# Read the data from the csv file
cw_data <- read.csv("Data_DMML.csv", header = TRUE)
print(cw_data)
#####################################################
# Exploratory Data Analysis (EDA)
# To display the structure of the data
str(cw_data)

# To display the summary statistics of the data
summary(cw_data)

# To explore the distribution of data using boxplots
boxplot(cw_data)

# To check the missing values in the dataset
missing_vals <- colSums(is.na(cw_data))
print(missing_vals)

# To scale the data and get the relevant variables from the given dataset
#clustering_data <- cw_data[, c("InDegree", "OutDegree", "TotalPosts", "MeanWordCount", "LikeRate")]
# Select relevant variables from the dataset
clustering_data <- cw_data[, c("InDegree", "OutDegree", "TotalPosts", 
                               "MeanWordCount", "LikeRate", "PercentQuestions", 
                                "MeanPostsPerThread", 
                               "InitiationRatio", "MeanPostsPerSubForum", 
                               "PercBiNeighbours", "AccountAge")]

# Print the first few rows of the updated clustered_data
head(clustering_data)

# To scale the clustering data
scaled_data <- scale(clustering_data)
#####################################################
# Elbow Graph
# Initialize vector to store within-cluster sum of squares (WCSS)
wcss <- numeric(10)

# Calculate WCSS for K = 1 to 10
for (i in 1:10) {
  kmeans_model <- kmeans(scaled_data, centers = i, nstart = 25)
  wcss[i] <- sum(kmeans_model$withinss)
}

# Plot the elbow graph
plot(1:10, wcss, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of Clusters (K)",
     ylab = "Total Within-Cluster Sum of Squares (WCSS)",
     main = "Elbow Method for Optimal K")

# Find the elbow point
elbow_point <- elbow_point <- which(diff(wcss) == max(diff(wcss)))
print(elbow_point)
#############################################
# Randomly choose K from 1 to 10
random_k <- sample(2:10, 1)

# Perform K-means clustering with the randomly chosen number of clusters
kmeans_model <- kmeans(scaled_data, centers = random_k, nstart = 25)

# Add cluster assignments to the original dataframe
clustered_data <- cw_data
clustered_data$Cluster <- kmeans_model$cluster

# Print the cluster centroids
print(kmeans_model$centers)

# Plot the clustering results
plot(scaled_data, col = clustered_data$Cluster, pch = 19,
     main = paste("K-means Clustering (K =", random_k, ")"),
     xlab = "InDegree", ylab = "OutDegree")

# Add cluster centroids to the plot
points(kmeans_model$centers, col = 1:random_k, pch = 8, cex = 2)
legend("topright", legend = 1:random_k, col = 1:random_k, pch = 8, title = "Cluster")


# Calculate silhouette score
silhouette_score <- silhouette(kmeans_model$cluster, dist(scaled_data))

# Print the average silhouette width
print(mean(silhouette_score[, "sil_width"]))


# Plot silhouette plot
#plot(silhouette_score)