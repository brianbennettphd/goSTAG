\name{loadGeneLists}
\alias{loadGeneLists}
\title{Load Gene Lists}
\description{
Loads gene lists from a file or directory.
}
\usage{
loadGeneLists(location, type = "GMT", sep = "\t", header = FALSE, col = 1)
}
\arguments{
    \item{location}{
    The location of the GMT file or the directory containing the gene lists.
    }
    \item{type}{
    A value indicating whether to load the gene lists from a single GMT file or a directory containing a separate file for each gene list. Acceptable options are "GMT" or "DIR".
    }
    \item{sep}{
    The field separator character by which values on each line are separated.
    }
    \item{header}{
    A logical value indicating whether the gene list files contain a header that should be ignored. Only applicable when type = "DIR".
    }
    \item{col}{
    The column in the gene lists files containing the genes. Only applicable when type = "DIR".
    }
}
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
tf <- tempfile()
writeLines( c(  "Gene_List_1\tNA\tGene1\tGene4",
                "Gene_List_2\tNA\tGene2\tGene7\tGene5",
                "Gene_List_3\tNA\tGene4\tGene8" ), tf )
gene_lists <- loadGeneLists( tf )
lapply( head( gene_lists ), head )

td <- tempdir()
unlink( paste( sep="/", td, list.files(td) ) )
writeLines( c( "Gene1", "Gene4" ), paste(sep="/",td,"Gene_List_1.txt") )
writeLines( c( "Gene2", "Gene7", "Gene5" ), paste(sep="/",td,"Gene_List_2.txt") )
writeLines( c( "Gene4", "Gene8" ), paste(sep="/",td,"Gene_List_3.txt") )
gene_lists <- loadGeneLists( td, type = "dir" )
lapply( head( gene_lists ), head )
}
