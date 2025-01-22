FROM rocker/r-ver:4

#requirements to be able to render Rmarkdown files as adopted from 
#https://library.virginia.edu/data/articles/how-to-use-docker-for-study-reproducibility-with-r-markdown
RUN apt-get update && apt-get upgrade && apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev \
        libblas-dev \
        liblapack-dev \ 
        gfortran \
        libnlopt-dev \
        cmake \
        libxml2-dev \
        libgsl-dev \
        libhdf5-dev \
        wget \ 
        graphviz \ 
        texlive-latex-extra \ 
        lmodern \ 
        perl && \ 
        /rocker_scripts/install_pandoc.sh && \
        install2.r rmarkdown

# #python packages to use leiden algorithm in Seurat
RUN apt update && install -y python3-leidenalg python3-numpy

# #cran and bioconductor packages
RUN Rscript -e 'install.packages(c("BiocManager", "ggrepel", "ggpubr", "Seurat", "leiden", "Rfast2", "hdf5r"), dependencies=TRUE)'
RUN Rscript -e 'BiocManager::install(c("fgsea", "EnhancedVolcano", "msigdbr", "glmGamPoi", "GLAD", "MAST"), ask=FALSE)'

