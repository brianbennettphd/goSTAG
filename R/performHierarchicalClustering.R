performHierarchicalClustering = function( enrichment_matrix, feature = "row", distance_method = "correlation", clustering_method = "average" ) {
    ## To cluster the columns, transpose the enrichment matrix
    final_matrix = switch( toupper( feature ),
        ROW = enrichment_matrix,
        COL = t(enrichment_matrix),
        stop( "Invalid feature" )
    )

    if( toupper( distance_method ) == "CORRELATION" ) {
        ## Cluster using the hclust function with a distance based on the correlation
        hclust( as.dist( 1-abs(cor(t(final_matrix))) ), method = clustering_method )
    } else {
        ## Cluster using the hclust function with a distance based on the dist function
        hclust( dist( final_matrix, method = distance_method ), method = clustering_method )
    }
}
