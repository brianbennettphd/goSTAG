groupClusters = function( hclust_results, distance_threshold = 0.2 ) {
    ## Define the recursive function to get the root leaf for a given step of the merging
    get_root = function( hclust_results, step ) {
        if( hclust_results$merge[ step, 1 ] < 0 ) {
            hclust_results$merge[ step, 1 ]
        } else {
            get_root( hclust_results, hclust_results$merge[ step, 1 ] )
        }
    }

    ## Initialize each leaf to their own cluster
    hclust_clusters = seq_len( length(hclust_results$order) )

    ## Make sure there are at least two leaves tha are closer than the threshold 
    if( sum(hclust_results$height<=distance_threshold) >= 1 ) {

        ## Cycle through all leaves whose distance is less than the threshold
        for( i in seq_len( sum(hclust_results$height<=distance_threshold) ) ) {

            ## Assign the leaf to a cluster based on who it is merged with
            if( hclust_results$merge[i,1] < 0 && hclust_results$merge[i,2] < 0 ) {
                hclust_clusters[ -hclust_results$merge[i,1] ] = hclust_clusters[ -hclust_results$merge[i,2] ]
            } else if( hclust_results$merge[i,1] < 0 && hclust_results$merge[i,2] > 0 ) {
                hclust_clusters[ -hclust_results$merge[i,1] ] = hclust_clusters[ -get_root( hclust_results, hclust_results$merge[i,2] ) ]
            } else if( hclust_results$merge[i,1] > 0 && hclust_results$merge[i,2] > 0 ) {
                hclust_clusters[ hclust_clusters == hclust_clusters[ -get_root( hclust_results, hclust_results$merge[i,1] ) ] ] = hclust_clusters[ -get_root( hclust_results, hclust_results$merge[i,2] ) ]
            }
        }
    }

    ## Give each leaf a cluster number
    hclust_final_clusters = rep( 1, length(hclust_results$order) )
    for( i in seq( 2, length(hclust_results$order) ) ) {
        if( hclust_clusters[ hclust_results$order[i] ] == hclust_clusters[ hclust_results$order[i-1] ] ) {
            hclust_final_clusters[i] = hclust_final_clusters[i-1]
        } else {
            hclust_final_clusters[i] = hclust_final_clusters[i-1] + 1
        }
    }

    ## Make the list of clusters containing the leaves within each cluster
    clusters = lapply( seq_len( max(hclust_final_clusters) ), function(i) {
        hclust_results$labels[ hclust_results$order[ hclust_final_clusters==i ] ]
    } )
    names(clusters) = paste( sep="", "Cluster", seq_len( max(hclust_final_clusters) ) )

    clusters
}
