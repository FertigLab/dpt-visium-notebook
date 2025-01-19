FROM docker.io/satijalab/seurat:5.0.0

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install libcurl4-openssl-dev libblas-dev \
            liblapack-dev gfortran pandoc libnlopt-dev \
            cmake -y && \
    pip install leidenalg

RUN Rscript -e 'BiocManager::install(c("fgsea", "EnhancedVolcano", "msigdbr"), ask=FALSE) ;\
                install.packages(c("ggrepel","ggpubr"), dependencies=TRUE, repos="https://cloud.r-project.org")'


