FROM docker.io/satijalab/seurat:5.0.0

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install pandoc -y && \
    pip install leidenalg

RUN Rscript -e 'BiocManager::install(c("fgsea", "EnhancedVolcano", "msigdbr"), ask=FALSE) ;\
                install.packages("ggrepel")'


