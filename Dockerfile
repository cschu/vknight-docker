FROM rocker/tidyverse

# Ignore interrupts during isntallation
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update

# Add packages to add new repos over HTTPS
RUN apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common libgirepository1.0-dev libdbus-glib-1-dev -y

# Enable CRAN repo
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
# RUN add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/'

# Install R
RUN apt update

RUN R --slave -e 'install.packages(c("devtools", "tidyverse", "optparse", "stringr", "progress"), repos="https://cran.rstudio.com/", dependencies=TRUE)'

COPY . /usr/local/myscripts
WORKDIR /usr/local/myscripts

# ENTRYPOINT ["Rscript", "--vanilla", "ExtractProfiledCounts_210823.R", "--libdir", "."]
