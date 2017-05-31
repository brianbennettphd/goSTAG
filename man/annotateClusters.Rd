\name{annotateClusters}
\alias{annotateClusters}
\title{Annotate Clusters}
\description{
Annotates each cluster of GO terms with the term containing the most paths to the root.
}
\usage{
annotateClusters(clusters)
}
\arguments{
    \item{clusters}{
    A list of vectors. Each element of the list corresponds to a cluster, and each vector contains the GO terms in the cluster.
    }
}
\details{
All of the GO terms within all of the clusters must belong to the same GO domain (either BP, CC, or MF).
}
\value{
A vector of cluster labels.
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
head( cluster_labels )
}
