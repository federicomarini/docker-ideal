# ARG 

# FROM rocker/rocker-versioned2:latest
FROM bioconductor/bioconductor_docker:RELEASE_3_18

ENV SHINY_INPUT_DIR="/shiny_input"
ENV SHINY_OUTPUT_DIR="/shiny_output"

# install Bioc
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); install.packages('BiocManager')" && \
    Rscript -e "BiocManager::install(ask=FALSE)" && \
    # install the package itself
    Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); options(Ncpus = 2); BiocManager::install('ideal', dependencies=TRUE)" && \
    Rscript -e "devtools::install_github('federicomarini/ideal', ref = 'intogalaxy')"

USER root

RUN mkdir -p /shiny_input /shiny_output
RUN chown rstudio:rstudio /shiny_input /shiny_output
USER rstudio

ADD app_setup.R /app_setup.R

EXPOSE 3838
CMD Rscript /app_setup.R