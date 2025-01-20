FROM rocker/r-ver:4

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install libcurl4-openssl-dev libblas-dev \
            liblapack-dev gfortran pandoc libnlopt-dev \
            cmake -y && \
    pip install leidenalg

RUN Rscript -e 'install.packages(c("BiocManager", "Seurat", "ggrepel", "ggpubr"), \
                    dependencies=TRUE, repos="https://cloud.r-project.org")'
RUN Rscript -e 'BiocManager::install(c("fgsea", "EnhancedVolcano", "msigdbr", "glmGamPoi", "GLAD"), ask=FALSE)'


