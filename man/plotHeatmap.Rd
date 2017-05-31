\name{plotHeatmap}
\alias{plotHeatmap}
\title{Plot Heatmap}
\description{
Plots a heatmap of goSTAG analysis results.
}
\usage{
plotHeatmap(enrichment_matrix, hclust_results, clusters, cluster_labels, sample_hclust_results = NULL, min_num_terms = 10, maximum_heatmap_value = 10, heatmap_colors = "auto", sample_colors = NULL, margin_size = 0.01, dendrogram_width = 0.4, cluster_label_width = 0.5, header_height = 0.3, sample_label_height = 0.6, dendrogram_lwd = 1, header_lwd = 1, cluster_label_cex = 1, sample_label_cex = 1)
}
\arguments{
    \item{enrichment_matrix}{
    A matrix of enrichment scores. Rows correspond to GO terms and columns correspond to gene lists.
    }
    \item{hclust_results}{
    An object of class "hclust" containing a tree produced by hierarchical clustering. This tree is for the GO terms (rows) in the enrichment matrix.
    }
    \item{clusters}{
    A list of vectors. Each element of the list corresponds to a cluster, and each vector contains the GO terms in the cluster.
    }
    \item{cluster_labels}{
    A vector of cluster labels.
    }
    \item{sample_hclust_results}{
    An object of class "hclust" containing a tree produced by hierarchical clustering. This tree is for the samples (columns) in the enrichment matrix. If NULL (default), the samples will appear in their original order with no dendrogram.
    }
    \item{min_num_terms}{
    The minimum number of GO terms required to plot a cluster label. Any cluster with fewer GO terms will not be labeled.
    }
    \item{maximum_heatmap_value}{
    The maximum value in the heatmap. Any values in the enrichment matrix greater than this value will be made equal to this value. This is to increase contrast in the heatmap by controlling outliers.
    }
    \item{heatmap_colors}{
    The color range for the heatmap. Available options are "auto", "extra", or a vector containing the color range. If "auto" (default), this function will use a color range from grey to red. If "extra", this function will use a color range from grey to yellow to red.
    }
    \item{sample_colors}{
    A vector of colors for the sample labels. If NULL (default), the sample labels will not have any color.
    }
    \item{margin_size}{
    The size of the margin between the elements of the plot, as a percentage of the entire width of the plot.
    }
    \item{dendrogram_width}{
    The size of the GO term dendrogram (including the cluster labels), as a percentage of the entire width of the plot (excluding the margins).
    }
    \item{cluster_label_width}{
    The size of the cluster labels, as a percentage of the GO term dendrogram.
    }
    \item{header_height}{
    The size of the header (including the sample labels), as a percentage of the entire height of the plot (excluding the margins).
    }
    \item{sample_label_height}{
    The size of the sample labels, as a percentage of the header.
    }
    \item{dendrogram_lwd}{
    The width of the GO term dendrogram lines.
    }
    \item{header_lwd}{
    The width of the sample dendrogram lines.
    }
    \item{cluster_label_cex}{
    A value that scales the cluster label text size.
    }
    \item{sample_label_cex}{
    A value that scales the sample label text size.
    }
}
\value{
None, the function is invoked for its side effect.
}
\references{
Bennett BD and Bushel PR. goSTAG: Gene Ontology Subtrees to Tag and Annotate Genes within a set. Source Code Biol Med. 2017 Apr 13.
}
\author{
Brian D. Bennett\cr
Pierre R. Bushel
}
\examples{
data( goSTAG_example_gene_lists )
go_terms <- loadGOTerms()
enrichment_matrix <- performGOEnrichment( goSTAG_example_gene_lists, go_terms )
hclust_results <- performHierarchicalClustering( enrichment_matrix )
clusters <- groupClusters( hclust_results )
cluster_labels <- annotateClusters( clusters )

plotHeatmap( enrichment_matrix, hclust_results, clusters, cluster_labels )
}
