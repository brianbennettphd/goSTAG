\name{goSTAG_example_gene_lists}
\alias{goSTAG_example_gene_lists}
\docType{data}
\title{goSTAG Example Gene Lists}
\description{
An example set of gene lists.
}
\usage{data(goSTAG_example_gene_lists)}
\value{
A list of vectors. Each element of the list corresponds to a gene list, and each vector contains the genes in the gene list.
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
lapply( head( goSTAG_example_gene_lists ), head )
}
\keyword{datasets}
