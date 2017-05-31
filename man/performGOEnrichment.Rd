\name{performGOEnrichment}
\alias{performGOEnrichment}
\title{Perform GO Enrichment}
\description{
Performs a GO enrichment analysis on a set of gene lists and GO terms. Will filter out GO terms having no significant enrichment in any of the gene lists.
}
\usage{
performGOEnrichment(gene_lists, go_terms, filter_method = "pval", significance_threshold = 0.05, p.adjust_method = "BH")
}
\arguments{
    \item{gene_lists}{
    A list of vectors. Each element of the list corresponds to a gene list, and each vector contains the genes in the gene list.
    }
    \item{go_terms}{
    A list of vectors. Each element of the list corresponds to a GO term, and each vector contains the genes associated with the GO term. The list must also have an additional element named "ALL", which is a vector that contains all annotated genes.
    }
    \item{filter_method}{
    A value indicating whether to filter out GO terms based on a nominal p-value or an adjusted p-value. Acceptable options are "pval" (nominal p-value) or "p.adjust" (adjusted p-value).
    }
    \item{significance_threshold}{
    The significance threshold at which to filter out GO terms. GO terms with a nominal or adjusted p-value (indicated by "filter_method") of greater than or equal to this threshold in all gene lists will be filtered out.
    }
    \item{p.adjust_method}{
    The correction method used to adjust the p-values. Available options are those of the "method" argument for the "p.adjust" function, which are currently "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", or "none". Only applicable when filter_method = "p.adjust".
    }
}
\value{
A matrix of enrichment scores. Rows correspond to GO terms and columns correspond to gene lists.
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
head( enrichment_matrix )
}
