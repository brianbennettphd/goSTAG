\name{rat_cancer_therapeutics_gene_lists}
\alias{rat_cancer_therapeutics_gene_lists}
\docType{data}
\title{Rat Cancer Therapeutics Gene Lists}
\description{
Differentially expressed genes from gene expression analysis (Affymetrix GeneChip Rat Genome 230 2.0 arrays) of samples acquired from the bone marrow of rats exposed to cancer therapeutic drugs (topotecan in combination with oxaliplatin) for 1, 6, or 24 hrs. Comparisons were treated samples to time-matched controls using limma with an FDR < 0.05 and absolute fold change > 2.0. Details of the analysis are as previously described (Davis et al., 2015). The raw data are available in the Gene Expression Omnibus under accession number GSE63902.
}
\usage{data(rat_cancer_therapeutics_gene_lists)}
\value{
A list of vectors. Each element of the list corresponds to a gene list, and each vector contains the genes in the gene list.
}
\references{
Davis M, Li J, Knight E, Eldridge SR, Daniels KK, Bushel PR. Toxicogenomics profiling of bone marrow from rats treated with topotecan in combination with oxaliplatin: a mechanistic strategy to inform combination toxicity. Front Genet. 2015 Feb 12;6:14.
}
\examples{
data( rat_cancer_therapeutics_gene_lists )
lapply( head( rat_cancer_therapeutics_gene_lists ), head )
}
\keyword{datasets}
