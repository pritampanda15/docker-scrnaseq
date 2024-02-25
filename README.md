# docker-scrnaseq
Tha package is available at docker hub. You can pull it as:
```
docker pull pritampkp15/scrnaseq-r-packages
```
The container contains all the necessary packages to run scRNAseq analysis using Seurat.
The packages involved in this docker container are:
```
# CRAN packages
install.packages(c("Seurat", "SeuratObject", "ggplot2", "patchwork", 
                   "tidyverse", "dplyr", "ggsci", "viridis", "pheatmap",
                   "devtools", "hdf5r", "remotes"))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.18")
# Bioconductor packages
BiocManager::install(c("BiocParallel", "DESeq2", "scran", "celldex", 
                       "glmGamPoi", "SingleR"))
# Install packages from GitHub
remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
```
Commands Used to build the container:
```
docker build -t scrnaseq-r-packages:latest .
docker tag scrnaseq-r-packages:latest pritampkp15/scrnaseq-r-packages:latest
docker push pritampkp15/scrnaseq-r-packages:latest
```
Docker file
```
# Start with a slimmer base image
FROM r-base:4.3.2

# Install R and only the necessary dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libglpk-dev \
    libpq-dev \
    libssl-dev \
    libhdf5-dev \
    libcurl4-openssl-dev \
    openssl \
    libxml2-dev \
    python3-pandas \
    python3.11-venv \
    python3-minimal \
    && rm -rf /var/lib/apt/lists/*

# It's assumed you've adjusted the R script to avoid installing suggested packages
# and any unnecessary dependencies.

# Create a directory and copy the R script in one layer
COPY install_packages.R /opt/software/setup/R/

# Install R packages
RUN Rscript /opt/software/setup/R/install_packages.R
```
After pulling the repo, you can load the libraries like:
```
library(SingleR)
library(scran)
library(ggplot2)
library(BiocParallel)
register(SnowParam(workers = 20, progressbar = TRUE))
library(Seurat)
library(ggplot2)
library(patchwork)
library(tidyverse)
library(hdf5r)
library(ggsci)
library(celldex)
library(RColorBrewer)
library(SingleCellExperiment)
library(patchwork)
library(glmGamPoi)
library(reticulate)
library(DoubletFinder)
library(cowplot)
library(viridis)
library(pheatmap)
```
