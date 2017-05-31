performGOEnrichment = function( gene_lists, go_terms, filter_method = "pval", significance_threshold = 0.05, p.adjust_method = "BH" ) {
    ## Separate all annotated genes from GO terms
    if( ! is.null( go_terms[["ALL"]] ) ) {
        all_genes = go_terms[["ALL"]]
        go_terms[["ALL"]] = NULL
    } else {
        stop( "All annotated genes entry missing in GO terms list" )
    }

    ## Calculate the gene list sizes and the universe size for the hypergeometric test
    gene_list_sizes = vapply( gene_lists, function(x) {
        length( intersect( toupper(x), toupper(all_genes) ) )
    }, integer(1) )
    universe_size = length( unique(toupper(all_genes)) )

    ## Calculate a p-value for each GO term and gene list using the hypergeometric test
    pvals = matrix( nrow = length(go_terms), ncol = length(gene_lists) )
    for( i in seq_len( length(go_terms) ) ) {
        m = length( intersect( toupper(go_terms[[i]]), toupper(all_genes) ) )
        pvals[i,] = vapply( seq_len( length(gene_lists) ), function(j) {
            x = length( intersect( toupper(go_terms[[i]]), toupper(gene_lists[[j]]) ) )
            k = gene_list_sizes[j]
            N = universe_size
            phyper( x-1, m, N-m, k, lower.tail=FALSE )
        }, numeric(1) )
    }
    rownames(pvals) = names(go_terms)
    colnames(pvals) = names(gene_lists)

    ## Use the p.adjust method to calculate adjusted p-values
    adjusted_pvals = matrix( nrow = length(go_terms), ncol = length(gene_lists) )
    for( i in seq_len( length(gene_lists) ) ) {
        adjusted_pvals[,i] = p.adjust( pvals[,i], method = p.adjust_method )
    }

    ## Filter out GO terms that don't have any significant tests
    if( toupper( filter_method ) == "PVAL" ) {
        final_matrix = pvals[ apply( pvals<significance_threshold, 1, sum ) > 0, ]
        final_matrix[ final_matrix>=significance_threshold ] = 1
    } else if( toupper( filter_method ) == "P.ADJUST" ) {
        final_matrix = pvals
        final_matrix[ adjusted_pvals>=significance_threshold ] = 1
        final_matrix = final_matrix[ apply( adjusted_pvals<significance_threshold, 1, sum ) > 0, ]
    } else {
        stop( "Invalid filter method" )
    }

    ## Tranform the p-values to -log10
    final_matrix = -log10( final_matrix )

    ## Throw an error if there are not two or more significant GO terms
    if( dim(final_matrix)[1] == 0 ) {
        stop( "Zero significant GO terms (try less stringent signficance threshold)" )
    } else if( dim(final_matrix)[1] == 1 ) {
        stop( "Only one significant GO term (try less stringent signficance threshold)" )
    }

    ## Remove infinite values by replacing them with the next highest value
    final_matrix[is.infinite(final_matrix)] = max(final_matrix[!is.infinite(final_matrix)])

    final_matrix
}
