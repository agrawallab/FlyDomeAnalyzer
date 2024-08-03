options(warn=-1)
library(igraph)

print('Hi! The script is trying to work')

# Load the LOI and NOI adjacency matrix from a CSV file
interaction_matrix_LOI <- as.matrix(read.csv("interactionmatrix_LOI.csv", header = TRUE))
interaction_matrix_NOI <- as.matrix(read.csv("interactionmatrix_NOI.csv", header = TRUE))

# Read the Analyzed_scores.csv file
df <- read.csv("Analyzed_scores.csv")

# Create the graph object
graph_LOI <- graph_from_adjacency_matrix(interaction_matrix_LOI, mode = "undirected", weighted = TRUE)
graph_NOI <- graph_from_adjacency_matrix(interaction_matrix_NOI, mode = "undirected", weighted = TRUE)

# Calculate modularity
communities_LOI <- cluster_walktrap(graph_LOI)
modularity_LOI <- modularity(graph_LOI, communities_LOI$membership)
communities_NOI <- cluster_walktrap(graph_NOI)
modularity_NOI <- modularity(graph_NOI, communities_NOI$membership)

# Creating a vector of the same modularity values for each fly
modularities_LOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
    modularities_LOI <- c(modularities_LOI, modularity_LOI)
}

modularities_NOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
    modularities_NOI <- c(modularities_NOI, modularity_NOI)
}

# Calculate strength and its standard deviation
strength_LOI <- strength(graph_LOI)
strength_sd_LOI <- sd(strength_LOI)
strength_NOI <- strength(graph_NOI)
strength_sd_NOI <- sd(strength_NOI)

# Creating a vector of the same strength_sd values for each fly
strength_sds_LOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
    strength_sds_LOI <- c(strength_sds_LOI,strength_sd_LOI)
}

strength_sds_NOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
    strength_sds_NOI <- c(strength_sds_NOI,strength_sd_NOI)
}

# Calculate betweenness centrality and its standard deviation
betweenness_LOI <- betweenness(graph_LOI)
betweenness_sd_LOI <- sd(betweenness_LOI)
betweenness_NOI <- betweenness(graph_NOI)
betweenness_sd_NOI <- sd(betweenness_NOI)

# Creating a vector of the same strength_sd values for each fly
betweenness_sds_LOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
    betweenness_sds_LOI <- c(betweenness_sds_LOI,betweenness_sd_LOI)
}

betweenness_sds_NOI <- c()
flies <- 1:nrow(df)
for (fly in flies) {
   betweenness_sds_NOI <- c(betweenness_sds_NOI,betweenness_sd_NOI)
}

#Calculating Density Values
sum_weights_LOI = 0
for (value in E(graph_LOI)$weight) {
	sum_weights_LOI = sum_weights_LOI + value
}

sum_weights_NOI = 0
for (value in E(graph_NOI)$weight) {
	sum_weights_NOI = sum_weights_LOI + value
}

density_LOI = sum_weights_LOI/((nrow(df))*(nrow(df)-1)*0.5)
density_NOI = sum_weights_NOI/((nrow(df))*(nrow(df)-1)*0.5)


# Adding a columns of data to data frame df
df$Strength_LOI <- strength_LOI
df$Strength_NOI <- strength_NOI
df$SD_Strength_LOI <- strength_sds_LOI
df$SD_Strength_NOI <- strength_sds_NOI

df$Betweenness_LOI <- betweenness_LOI
df$Betweenness_NOI <- betweenness_NOI
df$Betweenness_SD_LOI <- betweenness_sds_LOI
df$Betweenness_SD_NOI <- betweenness_sds_NOI

df$Modularities_LOI <- modularities_LOI
df$Modularities_NOI <- modularities_NOI

df$Density_LOI <- density_LOI
df$Density_NOI <- density_NOI

# Save the modified data frame
write.csv(df, "Analyzed_scores.csv", row.names = FALSE)

print('Hi! The script has finished running!')
