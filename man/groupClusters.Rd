\name{groupClusters}
\alias{groupClusters}
\title{Group Clusters}
\description{
Groups similar leaves of a hierarchical cluster analysis into clusters.
}
\usage{
groupClusters(hclust_results, distance_threshold = 0.2)
}
\arguments{
    \item{hclust_results}{
    An object of class "hclust" containing a tree produced by hierarchical clustering.
    }
    \item{distance_threshold}{
    The distance threshold at which to group leaves into clusters. Leaves whose distance is less than or equal to this threshold will be grouped together. A larger distance threshold will produce fewer clusters with more members, whereas a smaller one will produce more clusters with fewer members.
    }
}
\value{
A list of vectors. Each element of the list corresponds to a cluster, and each vector contains the GO terms in the cluster.
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
lapply( head( clusters ), head )
}
