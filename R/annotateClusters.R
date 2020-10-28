annotateClusters = function( clusters ) {
    ## Load the GO parents from the GO.db package
    parents = switch( Ontology( GOTERM[ clusters[[1]][1] ] ),
        BP = as.list(GOBPPARENTS),
        CC = as.list(GOCCPARENTS),
        MF = as.list(GOMFPARENTS),
        stop( "Invalid domain" )
    )

    ## Define the recursive function to get the number of paths to the root
    get_num_paths = memoise( function( go_id ) {
        this_parents = parents[[go_id]]
        this_parents = this_parents[ names(this_parents) == "isa" ]
        if( is.na( this_parents[1] ) ) {
            1L
        } else {
            sum( vapply( this_parents, get_num_paths, integer(1) ) )
        }
    } )

    ## Cycle through all the clusters
    idx = vapply( clusters, function(cluster) {
        ## Get the number of paths to the root for each GO term in the cluster
        num_paths = vapply( cluster, get_num_paths, integer(1) )

        ## Select the GO term with the largest number of paths to the root
        cluster[ which.max(num_paths) ]
    }, character(1) )

    Term( GOTERM[ idx ] )
}
