# **Email Interaction Network Analysis**
## **Introduction**
This project analyzes an email interaction network using **social network analysis (SNA)** techniques. The dataset is represented as a **directed graph**, where each node represents an individual, and each edge represents an email sent between two individuals.

Using the `igraph` package in **R**, we explore key network properties, compute centrality measures, detect communities, and visualize the structure of the network. The analysis provides insights into communication patterns within an organization.

## **Dataset**
- **File:** `email-Eu-core.txt`
- **Source:** [Stanford Network Analysis Project (SNAP)](https://snap.stanford.edu/data/)
- **Description:** Each row in the dataset represents a directed email exchange (e.g., `A B` means person A sent an email to person B).
- **Size:**
  - **Nodes (Individuals):** 1,005
  - **Edges (Email exchanges):** 25,571
- **Type:** Directed, unweighted network

## **Project Objectives**
- Convert the edge list into a directed graph for analysis.
- Compute and analyze key **network metrics**:
  - Node degree (in-degree, out-degree)
  - Average degree
  - Graph density
  - Clustering coefficient
  - Centrality measures (betweenness, closeness, eigenvector)
- **Detect and analyze communities** using the Walktrap algorithm.
- **Visualize** the network and key structural properties.
- **Export** results for further analysis.

  ```
  
## **Key Findings**
- **Degree Distribution**: Most individuals have a low number of connections, but a few key nodes have significantly high degrees.
- **Connectivity**: The network is **weakly connected** but not **strongly connected**, meaning there are paths between nodes, but not all communication is reciprocal.
- **Clustering Coefficient**: The low clustering coefficient suggests that individuals mainly communicate within small groups rather than forming tightly interconnected clusters.
- **Community Detection**: The Walktrap algorithm detected **multiple communities**, indicating distinct subgroups within the organization.
- **Graph Visualizations**: Various plots illustrate the structure of the network, highlighting important individuals and key communication hubs.

