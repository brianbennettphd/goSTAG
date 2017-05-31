\name{goSTAG-package}
\alias{goSTAG-package}
\alias{goSTAG}
\docType{package}
\title{goSTAG Package}
\description{
A tool to use GO Subtrees to Tag and Annotate Genes within a set.
}
\details{
    \tabular{ll}{
    Package: \tab goSTAG\cr
    Type: \tab Package\cr
    }
}
\author{
Brian D. Bennett\cr
Pierre R. Bushel
}
\references{
Bennett BD and Bushel PR. goSTAG: Gene Ontology Subtrees to Tag and Annotate Genes within a set. Source Code Biol Med. 2017 Apr 13.
}
\keyword{ package }
\examples{
data( goSTAG_example_gene_lists )
go_terms <- loadGOTerms()
enrichment_matrix <- performGOEnrichment( goSTAG_example_gene_lists, go_terms )
hclust_results <- performHierarchicalClustering( enrichment_matrix )
clusters <- groupClusters( hclust_results )
cluster_labels <- annotateClusters( clusters )
plotHeatmap( enrichment_matrix, hclust_results, clusters, cluster_labels )
}
