\name{loadGOTerms}
\alias{loadGOTerms}
\title{Load GO Terms}
\description{
Loads a list of GO terms and the genes associated with them.
}
\usage{
loadGOTerms(species = "human", domain = "BP", min_num_genes = 5, use_archived = TRUE)
}
\arguments{
    \item{species}{
    The species to use for associating genes with GO terms. Available options are "human", "mouse", or "rat".
    }
    \item{domain}{
    The GO domain to use. Acceptable options are "BP" (biological process), "CC" (cellular component), or "MF" (molecular function).
    }
    \item{min_num_genes}{
    The minimum number of genes required to be associated with each GO term. Any GO terms with fewer genes will be excluded.
    }
    \item{use_archived}{
    A logical value indicating whether to use an archived version of the gene associations. If FALSE, this function will use BioMart to generate the latest version of the gene associations, but may take several minutes. If TRUE (default), this function will use a previously generated version of the gene associations, which takes very little time.
    }
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
go_terms <- loadGOTerms()
lapply( head( go_terms ), head )
}
