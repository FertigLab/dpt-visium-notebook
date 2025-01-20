FROM rocker/r-ver:4

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y libcurl4-openssl-dev libblas-dev \
            liblapack-dev gfortran pandoc libnlopt-dev \
            cmake libxml2-dev python3 python3-pip
RUN apt install -y python3-leidenalg

RUN Rscript -e 'install.packages(c("BiocManager", "Seurat", "ggrepel", "ggpubr"), \
                    dependencies=TRUE, repos="https://cloud.r-project.org")'
RUN Rscript -e 'BiocManager::install(c("fgsea", "EnhancedVolcano", "msigdbr", "glmGamPoi", "GLAD"), ask=FALSE)'
