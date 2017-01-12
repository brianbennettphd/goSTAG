plotHeatmap = function( enrichment_matrix, hclust_results, clusters, cluster_labels, sample_hclust_results = NULL, min_num_terms = 10, maximum_heatmap_value = 10, heatmap_colors = "auto", sample_colors = NULL, margin_size = 0.01, dendrogram_width = 0.4, cluster_label_width = 0.5, header_height = 0.3, sample_label_height = 0.6, dendrogram_lwd = 1, header_lwd = 1, cluster_label_cex = 1, sample_label_cex = 1 ) {
    ## Skip the following if externally generated heatmap colors are provided
    if( length( heatmap_colors ) == 1 ) {
        ## Define the number of colors to use and the depth of the grey
        num_colors = 256
        grey_value = 200

        if( toupper(heatmap_colors) == "AUTO" ) {
            ## Define heatmap colors from grey to red
            heatmap_colors = vapply( seq_len( num_colors ), function(i) {
                paste( sep="", "#", format( as.hexmode( as.integer( grey_value + (255-grey_value) * (i-1) / (num_colors-1) ) ), width = 2 ), format( as.hexmode( as.integer( grey_value * (num_colors-i) / (num_colors-1) ) ), width = 2 ), format( as.hexmode( as.integer( grey_value * (num_colors-i) / (num_colors-1) ) ), width = 2 ) )
            }, character(1) )
        } else if( toupper(heatmap_colors) == "EXTRA" ) {
            ## Define heatmap colors from grey to yellow to red
            heatmap_colors1 = vapply( seq_len( num_colors ), function(i) {
                paste( sep="", "#", format( as.hexmode( as.integer( grey_value + (255-grey_value) * (i-1) / (num_colors-1) ) ), width = 2 ), format( as.hexmode( as.integer( grey_value + (255-grey_value) * (i-1) / (num_colors-1) ) ), width = 2 ), format( as.hexmode( as.integer( grey_value * (num_colors-i) / (num_colors-1) ) ), width = 2 ) )
            }, character(1) )
            heatmap_colors2 = vapply( seq_len( num_colors-1 ), function(i) {
                paste( sep="", "#ff", format( as.hexmode( as.integer( 255 * (num_colors-i-1) / (num_colors-1) ) ), width = 2 ), "00" )
            }, character(1) )
            heatmap_colors = c( heatmap_colors1, heatmap_colors2 )
        }
    }

    ## Define a function to get smaller labels
    get_smaller_labels = function( label ) {
        vapply( seq_len( nchar(label)-1 ), function(i) {
            paste( sep="", substr( label, 1, i ), "..." )
        }, character(1) )
    }

    ## Identify the distance cutoff in the dendrogram based on the number of clusters
    if( length(clusters) == length(hclust_results$order) ) {
        distance_cutoff = 0
    } else {
        distance_cutoff = hclust_results$height[ length(hclust_results$order) - length(clusters) ]
    }

    ## Create the properly formatted clusters dendrogram to plot
    label_width = max(hclust_results$height) * cluster_label_width / ( 1 - cluster_label_width )
    hclust_results$height[ hclust_results$height<=distance_cutoff ] = 0
    hclust_results$height = hclust_results$height + label_width
    dendrogram = cut( as.dendrogram( hclust_results ), h = distance_cutoff + label_width )$upper

    ## Create the header dendrogram if required
    if( is.null( sample_hclust_results ) ) {
        label_height = 1
    } else {
        label_height = max(sample_hclust_results$height) * sample_label_height / ( 1 - sample_label_height )
        sample_hclust_results$height = sample_hclust_results$height + label_height
        header_dendrogram = as.dendrogram( sample_hclust_results )
    }

    ## Set up the plot area and the three screens
    par( mar = c(0,0,0,0) )
    aspect_ratio = (par("pin")[1]/diff(par("usr")[1:2])) / (par("pin")[2]/diff(par("usr")[3:4]))
    heatmap_margin_y = margin_size * aspect_ratio
    x1 = margin_size
    x2 = margin_size + dendrogram_width * ( 1 - 3 * margin_size )
    x3 = 2 * margin_size + dendrogram_width * ( 1 - 3 * margin_size )
    x4 = 1 - margin_size
    y1 = heatmap_margin_y
    y2 = heatmap_margin_y + ( 1 - header_height ) * ( 1 - 3 * heatmap_margin_y )
    y3 = 2 * heatmap_margin_y + ( 1 - header_height ) * ( 1 - 3 * heatmap_margin_y )
    y4 = 1 - heatmap_margin_y
    screens = split.screen( rbind( c(x3,x4,y1,y2), c(0,x3,0,y3), c(x2,1,y2,1) ) )

    ## Plot screen one, the heatmap
    screen(screens[1])

    ## Floor any values in the matrix that are greater than the maximum
    enrichment_matrix[ enrichment_matrix > maximum_heatmap_value ] = maximum_heatmap_value

    ## Plot the heatmap
    if( is.null( sample_hclust_results ) ) {
        image( t( enrichment_matrix[ hclust_results$order, ] ), axes = FALSE, col = heatmap_colors )
    } else {
        image( t( enrichment_matrix[ hclust_results$order, sample_hclust_results$order ] ), axes = FALSE, col = heatmap_colors )
    }

    ## Plot screen two, the clusters dendrogram
    screen(screens[2])
    par( lwd = dendrogram_lwd )
    x_size = max(hclust_results$height)
    x_margin = x_size * ( margin_size / ( dendrogram_width * ( 1 - 3 * margin_size ) ) )
    y_size = length(hclust_results$order)
    y_margin = y_size * ( heatmap_margin_y / ( ( 1 - header_height ) * ( 1 - 3 * heatmap_margin_y ) ) )

    ## Plot the dendrogram
    plot( dendrogram, center = TRUE, horiz = TRUE, leaflab = "none", axes = FALSE, xaxs="i", yaxs="i", xlim = c(x_size+x_margin,-x_margin), ylim = c(-y_margin+0.5,y_size+y_margin+0.5) )

    ## Plot a white box to hide dendrogram lines past the label
    rect( -x_margin, -y_margin, label_width, y_size+y_margin, col = "white", border = "NA" )

    ## Cycle through all clusters
    cluster_num_members = vapply( clusters, length, integer(1) )
    for( i in seq_len( length(clusters) ) ) {
        ## Only plot the label if it has more than the required number of terms
        if( cluster_num_members[i] >= min_num_terms ) {
            ## Plot the label box
            rect( 0, sum(cluster_num_members[seq_len(i-1)])+0.5, label_width, sum(cluster_num_members[seq_len(i)])+0.5 )

            ## Get the label and make it smaller if it is bigger than the box
            label = cluster_labels[i]
            if( - strwidth( label, cex = cluster_label_cex ) > label_width ) {
                smaller_labels = get_smaller_labels( label )
                label = smaller_labels[ max( which( - strwidth( smaller_labels, cex = cluster_label_cex ) <= label_width ) ) ]
            }

            ## Plot the label text
            text( label_width/2, sum(cluster_num_members[seq_len(i-1)])+0.5+cluster_num_members[i]/2, label, cex = cluster_label_cex )
        }
    }

    ## Plot screen three, the header
    screen(screens[3])
    par( lwd = header_lwd )
    x_size = dim(enrichment_matrix)[2]
    x_margin = x_size * ( margin_size / ( ( 1 - dendrogram_width ) * ( 1 - 3 * margin_size ) ) )
    if( is.null( sample_hclust_results ) ) {
        y_size = label_height
    } else {
        y_size = max(sample_hclust_results$height)
    }
    y_margin = y_size * ( heatmap_margin_y / ( header_height * ( 1 - 3 * heatmap_margin_y ) ) )

    ## The header is different based on whether there is a dendrogram or not
    if( is.null( sample_hclust_results ) ) {
        ## Set up the plot area with no dendrogram
        plot( NULL, axes = FALSE, xaxs="i", yaxs="i",  xlim = c(-x_margin+0.5,x_size+x_margin+0.5), ylim = c(-y_margin,y_size+y_margin) )
    } else {
        ## Plot the dendrogam
        plot( header_dendrogram, leaflab = "none", axes = FALSE, xaxs="i", yaxs="i", xlim = c(-x_margin+0.5,x_size+x_margin+0.5), ylim = c(-y_margin,y_size+y_margin) )

        ## Plot a white box to hide dendrogram lines past the label
        rect( -x_margin, -y_margin, x_size+x_margin, label_height, col = "white", border = "NA" )
    }

    ## Cycle through all samples
    for( i in seq_len( dim(enrichment_matrix)[2] ) ) {
        ## Plot the label box
        if( is.null( sample_colors ) ) {
            if( ! is.null( sample_hclust_results ) ) {
                rect( i-1+0.5, 0, i+0.5, label_height )
            }
        } else {
            if( is.null( sample_hclust_results ) ) {
                rect( i-1+0.5, 0, i+0.5, label_height, col = sample_colors[i] )
            } else {
                rect( i-1+0.5, 0, i+0.5, label_height, col = sample_colors[sample_hclust_results$order][i] )
            }
        }

        ## Get the label and make it smaller if it is bigger than the box
        if( is.null( sample_hclust_results ) ) {
            label = colnames(enrichment_matrix)[i]
        } else {
            label = colnames(enrichment_matrix)[sample_hclust_results$order][i]
        }
        if( strwidth( label, cex = sample_label_cex ) * ((y_size+2*y_margin)/(x_size+2*x_margin)) * (par("pin")[1]/par("pin")[2]) > label_height ) {
            smaller_labels = get_smaller_labels( label )
            label = smaller_labels[ max( which( strwidth( smaller_labels, cex = sample_label_cex ) * ((y_size+2*y_margin)/(x_size+2*x_margin)) * (par("pin")[1]/par("pin")[2]) <= label_height ) ) ]
        }

        ## Plot the label text
        if( is.null( sample_colors ) && is.null( sample_hclust_results ) ) {
            text( i, 0, label, cex = sample_label_cex, srt = 90, pos = 4 )
        } else {
            text( i, label_height/2, label, cex = sample_label_cex, srt = 90 )
        }
    }

    ## Close the screens
    close.screen( all.screens = TRUE )
}
