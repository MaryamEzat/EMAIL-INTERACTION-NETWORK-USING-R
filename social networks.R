# Load necessary libraries
library(igraph)

# Path to a specific edge list file
folder_path <- "/Users/lapstore/Downloads/email-Eu-core.txt"

# Load the dataset (edge list format)
edges <- read.table(folder_path, header = FALSE, stringsAsFactors = FALSE)

# Inspect the first few rows to understand the structure
cat("First few rows of the dataset:\n")
head(edges)
# Add 1 to all vertex IDs
edges <- edges + 1
head(edges)

# Create an igraph object from the edge list
# Convert the edge list to an igraph object
graph <- graph_from_edgelist(as.matrix(edges), directed = TRUE)

# Check the graph summary
summary(graph)

# Summary of the graph
cat("Graph Summary:\n")
summary(graph)

# Dimensions of the edge list
cat("Number of edges:", nrow(edges), "\n")
cat("Number of vertices:", vcount(graph), "\n")

# In-degree and out-degree
in_degree <- degree(graph, mode = "in")
out_degree <- degree(graph, mode = "out")

# Print the first few values of each
cat("In-Degree (first 6):\n")
head(in_degree)
cat("Out-Degree (first 6):\n")
head(out_degree)

# Plot degree distributions
hist(in_degree, breaks = 30, main = "In-Degree Distribution", xlab = "In-Degree")
hist(out_degree, breaks = 30, main = "Out-Degree Distribution", xlab = "Out-Degree")

# Calculate average degree
avg_degree <- mean(degree(graph))
cat("Average Degree:", avg_degree, "\n")

# Check connectivity
is_strongly_connected <- is_connected(graph, mode = "strong")
is_weakly_connected <- is_connected(graph, mode = "weak")
cat("Strongly Connected:", is_strongly_connected, "\n")
cat("Weakly Connected:", is_weakly_connected, "\n")

# Graph density
graph_density <- edge_density(graph)
cat("Graph Density:", graph_density, "\n")

# Global clustering coefficient
global_clustering <- transitivity(graph, type = "global")
cat("Global Clustering Coefficient:", global_clustering, "\n")

# Betweenness centrality
betweenness_centrality <- betweenness(graph, directed = TRUE)
cat("Betweenness Centrality (first 6):\n")
head(betweenness_centrality)

# Closeness centrality
closeness_centrality <- closeness(graph, mode = "all")
cat("Closeness Centrality (first 6):\n")
head(closeness_centrality)

# Eigenvector centrality
eigenvector_centrality <- eigen_centrality(graph)$vector
cat("Eigenvector Centrality (first 6):\n")
head(eigenvector_centrality)

# Adjacency matrix
adj_matrix <- as_adjacency_matrix(graph, sparse = FALSE)
cat("Adjacency Matrix Dimensions:", dim(adj_matrix), "\n")

is_bipartite(graph)

# Incidence matrix
inc_matrix <- as_biadjacency_matrix(graph, sparse = FALSE)
cat("Incidence Matrix Dimensions:", dim(inc_matrix), "\n")

# Edge list
edge_list <- as_edgelist(graph)
cat("First few edges:\n")
head(edge_list)

# Adjacency list
adj_list <- as_adj_list(graph)
cat("First few adjacency lists:\n")
head(adj_list)

# Visualizations
par(mfrow = c(2, 2))  # Plot multiple graphs
plot(graph, vertex.size = 5, vertex.label = NA, main = "Original Graph")
plot(make_full_graph(10, directed = TRUE), main = "Complete Graph", vertex.size = 5, vertex.label = NA)
plot(make_ring(10), main = "Cycle Graph", vertex.size = 5, vertex.label = NA)
plot(erdos.renyi.game(vcount(graph), ecount(graph), type = "gnm", directed = TRUE), main = "Random Graph", vertex.size = 5, vertex.label = NA)
par(mfrow = c(1, 1))  # Reset plotting layout

# Save visualizations
png("graph_visualization.png")
plot(graph, vertex.size = 5, vertex.label = NA, main = "Graph Visualization")
dev.off()

# Clustering
communities <- cluster_walktrap(graph)
cat("Number of Communities Detected:", length(communities), "\n")


V(graph)$name <- as.character(seq_len(vcount(graph)))

cat("Number of vertices in the graph:", vcount(graph), "\n")
print(V(graph)$name)

cat("Length of in_degree:", length(in_degree), "\n")
cat("Length of out_degree:", length(out_degree), "\n")
cat("Length of betweenness_centrality:", length(betweenness_centrality), "\n")
cat("Length of closeness_centrality:", length(closeness_centrality), "\n")
cat("Length of eigenvector_centrality:", length(eigenvector_centrality), "\n")


in_degree <- degree(graph, mode = "in")
out_degree <- degree(graph, mode = "out")
betweenness_centrality <- betweenness(graph, directed = TRUE)
closeness_centrality <- closeness(graph, mode = "all")
eigenvector_centrality <- eigen_centrality(graph)$vector


if (all(c(length(in_degree), length(out_degree), length(betweenness_centrality), 
          length(closeness_centrality), length(eigenvector_centrality)) == vcount(graph))) {
  cat("All vectors have consistent lengths.\n")
} else {
  cat("Mismatch in vector lengths.\n")
}

results <- data.frame(
  Node = V(graph)$name,
  In_Degree = in_degree,
  Out_Degree = out_degree,
  Betweenness = betweenness_centrality,
  Closeness = closeness_centrality,
  Eigenvector = eigenvector_centrality
)

write.csv(results, "graph_analysis_results.csv", row.names = FALSE)
cat("Results saved to graph_analysis_results.csv\n")

plot(graph, 
     vertex.size = degree(graph) * 2,  # Size based on degree
     vertex.color = ifelse(degree(graph) > median(degree(graph)), "red", "blue"), 
     vertex.label = NA, 
     main = "Graph Visualization with Degree-Based Colors")

largest_component <- induced_subgraph(graph, which(components(graph)$membership == which.max(components(graph)$csize)))
plot(largest_component, vertex.size = 5, vertex.label = NA, main = "Largest Connected Component")

community <- cluster_walktrap(graph)
plot(community, graph, vertex.size = 5, main = "Community Detection")

# Graph Visualization with Degree-Based Colors
pdf("graph_degree_based_colors.pdf", width = 12, height = 12)  # Width and height in inches
plot(graph, 
     vertex.size = degree(graph) * 2, 
     vertex.color = ifelse(degree(graph) > median(degree(graph)), "red", "blue"), 
     vertex.label = NA, 
     main = "Graph Visualization with Degree-Based Colors")
dev.off()

# Largest Connected Component
pdf("largest_connected_component.pdf", width = 12, height = 12)
plot(largest_component, vertex.size = 5, vertex.label = NA, main = "Largest Connected Component")
dev.off()

# Community Detection
pdf("community_detection.pdf", width = 12, height = 12)
plot(community, graph, vertex.size = 5, main = "Community Detection")
dev.off()

