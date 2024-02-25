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

# Further cleanup if applicable
