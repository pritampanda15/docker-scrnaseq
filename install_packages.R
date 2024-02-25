# install_packages.R

# CRAN packages
install.packages(c("Seurat", "SeuratObject", "ggplot2", "patchwork", 
                   "tidyverse", "dplyr", "ggsci", "viridis", "pheatmap",
                   "devtools", "hdf5r", "remotes"))

# Check for BiocManager and install if not present
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Specify the version of Bioconductor to use
BiocManager::install(version = "3.18")

# Bioconductor packages
BiocManager::install(c("BiocParallel", "DESeq2", "scran", "celldex", 
                       "glmGamPoi", "SingleR"))

# Install packages from GitHub
remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
