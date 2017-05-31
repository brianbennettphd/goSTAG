loadGOTerms = function( species = "human", domain = "BP", min_num_genes = 5, use_archived = TRUE ) {
    ## Make sure a valid domain is specified
    if( ! toupper(domain) %in% c("BP","CC","MF") ) {
        stop( "Invalid domain" )
    }

    ## Load the domains for each GO term from the GO.db package
    domains = Ontology(GOTERM)

    if( use_archived == TRUE ) {
        ## Load the gene annotations from the archived version within the package
        go_genes_all = switch( toupper(species),
            HUMAN = goSTAG::goSTAG_go_genes_human,
            MOUSE = goSTAG::goSTAG_go_genes_mouse,
            RAT = goSTAG::goSTAG_go_genes_rat,
            stop( "Invalid species" )
        )

        ## Filter the GO terms to only include those in the specified domain
        go_genes = go_genes_all[ domains[names(go_genes_all)]==toupper(domain) ]

        ## Add full list of all annotated genes
        go_genes[[ "ALL" ]] = go_genes_all[[ "ALL" ]]
    } else {
        ## Set the correct BioMart dataset and gene symbol attribute for the specified species
        ensembl_dataset = switch( toupper(species),
            HUMAN = "hsapiens_gene_ensembl",
            MOUSE = "mmusculus_gene_ensembl",
            RAT = "rnorvegicus_gene_ensembl",
            stop( "Invalid species" )
        )
        gene_symbol_attribute = switch( toupper(species),
            HUMAN = "hgnc_symbol",
            MOUSE = "mgi_symbol",
            RAT = "rgd_symbol",
            stop( "Invalid species" )
        )

        ## Connect to BioMart using the biomaRt package
        ensembl_mart = useMart( biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice", dataset=ensembl_dataset )

        ## Get the complete list of GO terms and associated gene symbols from BioMart
        query = getBM( attributes = c(gene_symbol_attribute,"go_id"), mart = ensembl_mart )
        query = query[ query[,1]!="", ]
        query = query[ query[,2]!="", ]

        ## Filter the BioMart query to only include valid GO terms from the specified domain
        go_ids = unique(query[,2])
        go_ids_filtered = go_ids[ domains[go_ids]==toupper(domain) ]
        go_ids_filtered = go_ids_filtered[ ! is.na(go_ids_filtered) ]
        query_filtered = query[ query[,2] %in% go_ids_filtered, ]

        ## Get the list of gene annotations for each GO term
        go_genes = lapply( go_ids_filtered, function(x) unique(query_filtered[query_filtered[,2]==x,1]) )
        names(go_genes) = go_ids_filtered

        ## Add full list of all annotated genes
        go_genes[[ "ALL" ]] = unique(query[,1])
    }

    ## Filter out any GO term with fewer that the specified minimum number of genes
    go_genes[ lapply(go_genes,length) >= min_num_genes ]
}
