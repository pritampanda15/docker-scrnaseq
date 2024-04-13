# Dockerfile for Seurat 4.3.0
FROM rocker/r-ver:4.3.2

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install Seurat's system dependencies
RUN apt-get update
RUN apt-get install -y \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpng-dev \
    libboost-all-dev \
    libxml2-dev \
    openjdk-8-jdk \
    python3-dev \
    python3-pip \
    wget \
    git \
    libfftw3-dev \
    libgsl-dev \
    pkg-config

RUN apt-get install -y llvm



# Install UMAP
RUN LLVM_CONFIG=/usr/lib/llvm/bin/llvm-config pip3 install llvmlite
RUN pip3 install numpy
RUN pip3 install umap-learn

# Install FIt-SNE
RUN git clone --branch v1.2.1 https://github.com/KlugerLab/FIt-SNE.git
RUN g++ -std=c++11 -O3 FIt-SNE/src/sptree.cpp FIt-SNE/src/tsne.cpp FIt-SNE/src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm

#Install Packages
RUN R --no-echo --no-restore --no-save -e "install.packages('VGAM')"
RUN R --no-echo --no-restore --no-save -e "install.packages('R.utils')"
RUN R --no-echo --no-restore --no-save -e "install.packages('metap')"
RUN R --no-echo --no-restore --no-save -e "install.packages('Rfast2')"
RUN R --no-echo --no-restore --no-save -e "install.packages('ape')"
RUN R --no-echo --no-restore --no-save -e "install.packages('enrichR')"
RUN R --no-echo --no-restore --no-save -e "install.packages('mixtools')"
RUN R --no-echo --no-restore --no-save -e "install.packages('spatstat.explore')"
RUN R --no-echo --no-restore --no-save -e "install.packages('spatstat.geom')"
RUN R --no-echo --no-restore --no-save -e "install.packages('hdf5r')"
RUN R --no-echo --no-restore --no-save -e "install.packages('cowplot')"
RUN R --no-echo --no-restore --no-save -e "install.packages('pacman')"
RUN R --no-echo --no-restore --no-save -e "install.packages('patchwork')"
RUN R --no-echo --no-restore --no-save -e "install.packages('pheatmap')"
RUN R --no-echo --no-restore --no-save -e "install.packages('ggplot2')"
RUN R --no-echo --no-restore --no-save -e "install.packages('ggrepel')"
RUN R --no-echo --no-restore --no-save -e "install.packages('Matrix')"
RUN R --no-echo --no-restore --no-save -e "install.packages('rgeos')"
RUN R --no-echo --no-restore --no-save -e "install.packages('remotes')"
RUN R --no-echo --no-restore --no-save -e "install.packages('Seurat')"
RUN R --no-echo --no-restore --no-save -e "install.packages('devtools')"
RUN R --no-echo --no-restore --no-save -e "install.packages('tidyverse')"
RUN R --no-echo --no-restore --no-save -e "install.packages('ggsci')"
RUN R --no-echo --no-restore --no-save -e "install.packages('viridis')"
RUN R --no-echo --no-restore --no-save -e "install.packages('dplyr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('BiocManager')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(version = "3.18")"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('multtest')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('S4Vectors')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('SummarizedExperiment')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('SingleCellExperiment')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('MAST')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('DESeq2')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('BiocGenerics')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('GenomicRanges')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('rtracklayer')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('celldex')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('Biobase')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('limma')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('glmGamPoi')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('SingleR')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('SeuratObject')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('DESeq2')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('scran')"

RUN R --no-echo --no-restore --no-save -e "remotes::install_github('mojaveazure/seurat-disk')"
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('cole-trapnell-lab/monocle3')"
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('immunogenomics/presto')"
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"

CMD [ "R" ]
