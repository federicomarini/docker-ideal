# ARG 

# FROM rocker/rocker-versioned2:latest
FROM bioconductor/bioconductor_docker:devel

# WORKDIR 

# install Bioc
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); install.packages('BiocManager')"
RUN Rscript -e "BiocManager::install(ask=FALSE)"

# install the package itself
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); options(Ncpus = 2); BiocManager::install('ideal', dependencies=TRUE)"

RUN Rscript -e "devtools::install_github('federicomarini/ideal', ref = 'intogalaxy')"


USER root

RUN mkdir -p /shiny_input /shiny_output
RUN chown rstudio:rstudio /shiny_input /shiny_output
USER rstudio

ENV SHINY_INPUT_DIR="/shiny_input"

ENV SHINY_OUTPUT_DIR="/shiny_output"

EXPOSE 3838

ADD app_setup.R /app_setup.R

CMD Rscript /app_setup.R

