\name{performHierarchicalClustering}
\alias{performHierarchicalClustering}
\title{Perform Hierarchical Clustering}
\description{
Performs a hierarchical clustering analysis on a GO enrichment matrix.
}
\usage{
performHierarchicalClustering(enrichment_matrix, feature = "row", distance_method = "correlation", clustering_method = "average")
}
\arguments{
    \item{enrichment_matrix}{
    A matrix of enrichment scores. Rows correspond to GO terms and columns correspond to gene lists.
    }
    \item{feature}{
    A value indicating whether to cluster the rows or the columns. Acceptable options are "row" or "col".
    }
    \item{distance_method}{
    The distance measure to use when generating the distance matrix. If "correlation" (default), this function will use one minus the absolute value of the correlation to measure distance. Otherwise, this function will use the "dist" function to measure distance. Available options are those of the "method" argument for the "dist" function, which are currently "euclidean", "maximum", "manhattan", "canberra", "binary", or "minkowski".
    }
    \item{clustering_method}{
    The agglomeration method to use when performing the hierarchical clustering. Available options are those of the "method" argument for the "hclust" function, which are currently "ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", or "centroid".
    }
}
\value{
An object of class "hclust" containing a tree produced by hierarchical clustering.
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
sample_hclust_results <- performHierarchicalClustering( enrichment_matrix, feature = "col" )
}
