process RENDER_RMD {
    tag "$meta.id"
    label 'process_medium'
    container 'ghcr.io/fertiglab/dpt-visium-notebook:main'

    input:
        tuple val(meta), path(data), path(coda)
        path(notebook)
    output:
        tuple val(meta), path("${prefix}/notebook.html"), emit: notebook
        path "versions.yml"                             , emit: versions

    script:
    def prefix = "${meta.id}"
    def nb_file = notebook.simpleName
    """
    #!/usr/bin/env Rscript
    dir.create("${prefix}", showWarnings = FALSE, recursive = TRUE)
    par <- list(spaceranger_dir="${data}",coda_ann_path="${coda}")
    outfile <- "${prefix}/${nb_file}.html"
    rmarkdown::render("${notebook}", output_file=outfile, params=par)
    sinfo <- sessionInfo()
    versions <- lapply(sinfo[["otherPkgs"]], function(x) {sprintf("  %s:%s",x[["Package"]],x[["Version"]])})
    cat("${task.process}",":\n", file="versions.yml", sep="")
    cat(unlist(versions), file="versions.yml", append=TRUE, sep="\n")'
    """
}