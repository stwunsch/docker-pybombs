# PyBOMBS

# Derive from Ubuntu
FROM ubuntu:14.04

# Set prefix variable
ENV PyBOMBS_prefix myprefix

# Setup packages which should be installed by PyBOMBS
#ENV packages "cmake swig numpy fftw boost cppunit"

# Update apt-get
RUN apt-get update

# Install PyBOMBS dependencies
RUN apt-get install -y \
        python-pip \
        python-yaml \
        git-core

# Install PyBOMBS
RUN pip install PyBOMBS

# Add recipes to PyBOMBS
RUN pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
RUN pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git

# Setup environment
RUN pybombs prefix init /usr/local/ -a ${PyBOMBS_prefix}
RUN echo "source /usr/local/setup_env.sh" > /root/.bashrc

# Install previously selected packages
#RUN pybombs -p ${PyBOMBS_prefix} -v install ${packages}
