\name{goSTAG_go_genes_mouse}
\alias{goSTAG_go_genes_mouse}
\docType{data}
\title{goSTAG GO Genes (Mouse)}
\description{
A list of GO terms and the mouse genes associated with them.
}
\usage{data(goSTAG_go_genes_mouse)}
\details{
This data is meant for internal goSTAG use.
}
\value{
A list of vectors. Each element of the list corresponds to a GO term, and each vector contains the genes associated with the GO term. The list also has an additional element named "ALL", which is a vector that contains all annotated genes.
}
\references{
Bennett BD and Bushel PR. goSTAG: Gene Ontology Subtrees to Tag and Annotate Genes within a set. Source Code Biol Med. 2017 Apr 13.
}
\author{
Brian D. Bennett\cr
Pierre R. Bushel
}
\examples{
data( goSTAG_go_genes_mouse )
lapply( head( goSTAG_go_genes_mouse ), head )
}
\keyword{datasets}
