# PyBOMBS

# Derive from Ubuntu
FROM ubuntu:16.04

# Set prefix variables
ENV PyBOMBS_prefix myprefix
ENV PyBOMBS_init /pybombs

# Update apt-get
RUN apt-get update

# Install PyBOMBS dependencies
RUN apt-get install -y \
        python-pip \
        python-yaml \
        python-setuptools \
        git-core

# Install PyBOMBS
RUN pip install PyBOMBS

# Add recipes to PyBOMBS
RUN pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
RUN pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git

# Setup environment
RUN pybombs prefix init ${PyBOMBS_init} -a ${PyBOMBS_prefix}
RUN echo "source "${PyBOMBS_init}"/setup_env.sh" > /root/.bashrc
