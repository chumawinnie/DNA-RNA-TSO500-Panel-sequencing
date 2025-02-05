# Install required packages
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
# Install the viridis package if not already installed
if (!requireNamespace("viridis", quietly = TRUE)) {
  install.packages("viridis")
}

if (!requireNamespace("RColorBrewer", quietly = TRUE)) {
  install.packages("RColorBrewer")
}

install.packages("reshape2")
#Downloading Github-repo of immuneeconv
remotes::install_github("omnideconv/immunedeconv")
remotes::install_github("icbi-lab/immunedeconv")



# Load required libraries
library(immunedeconv)
library(ggplot2)
library(viridis)
library(RColorBrewer)
library(reshape2)
# Replace "file.txt" with the path to your file
gene_expression <- read.table("/home/obiora/Downloads/salmon.merged.gene_counts.tsv", header = TRUE, sep = "\t")
# Check the first few rows
head(gene_expression)

# Convert to numeric matrix (excluding the first column)
gene_expression_matrix <- as.matrix(gene_expression[, -1])

# Ensure row names are gene names
rownames(gene_expression_matrix) <- gene_expression$gene_name

# Perform deconvolution using xCell method
result_Deconvolution <- deconvolute(gene_expression_matrix, method = "xcell")

# Write the result to a CSV file
write.csv(result_Deconvolution, "deconvolution_results.csv", row.names = FALSE)

# Convert the result to a format suitable for ggplot2
result_melted <- melt(result_Deconvolution, id.vars = "cell_type")


# Install the required package for predefined palettes
# Define a custom color palette to match the provided image
custom_colors <- c(
  "Action" = "#377eb8",      # Blue
  "Adventure" = "#4daf4a",   # Green
  "Comedy" = "#984ea3",      # Purple
  "Drama" = "#ff7f00",       # Orange
  "Horror" = "#e41a1c",      # Red
  "Romance" = "#ffff33",     # Yellow
  "Thriller" = "#a65628"     # Brown
)

# Adjust this to reflect the actual `cell_type` values in your data
num_colors <- length(unique(result_melted$cell_type))
colors <- if (num_colors <= length(custom_colors)) {
  custom_colors[1:num_colors]
} else {
  # For more cell types, extend the custom palette
  colorRampPalette(custom_colors)(num_colors)
}

# Create the stacked bar plot with custom colors
ggplot(result_melted, aes(x = variable, y = value, fill = cell_type)) +
  geom_bar(stat = "identity", width = 0.6) +  # Adjust bar width
  theme_minimal() +
  scale_fill_manual(values = colors) +       # Use the custom palette
  labs(
    title = "Immune Cell Deconvolution Results",
    x = "Sample",
    y = "Proportion",
    fill = "Cell Type"
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold"),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
