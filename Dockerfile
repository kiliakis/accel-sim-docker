FROM ubuntu:18.04

USER root
WORKDIR /root

COPY container_data/* /root/

ENV CUDA_INSTALL_PATH="/root/install/cuda" \
    PATH="/root/install/cuda/bin:/usr/bin:/usr/local/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:"

RUN apt-get update -y && \
    apt-get install -y build-essential apt-utils wget vim htop git curl python \
        software-properties-common xutils-dev bison zlib1g-dev flex \
        libglu1-mesa-dev gcc g++ curl gdb libssl-dev libxml2-dev libboost-all-dev \
        freeglut3 freeglut3-dev gfortran scons zip libopenmpi-dev openmpi-bin \
        python-setuptools python-dev python-pip && \
    pip install pyyaml==5.1

RUN wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda_11.0.1_450.36.06_linux.run
    #sh cuda_11.0.1_450.36.06_linux.run --silent --toolkit --toolkitpath=/root/install/cuda && \
    #sh cuda_11.0.1_450.36.06_linux.run --silent --samples --samplespath=/root/install/cuda
#    rm cuda_11.0.1_450.36.06_linux.run

RUN cd /root && git clone https://github.com/accel-sim/accel-sim-framework.git && \
    cd /root && git clone https://github.com/accel-sim/gpu-app-collection && \
    cd /root && git clone --branch=gpusim https://github.com/kiliakis/config.git && \
    cd config && cp -r .vim .vimrc .gitconfig .git-* /root/

RUN cd /root && mkdir install && \
    wget https://cernbox.cern.ch/index.php/s/XU1XLVfLu8oHRFo/download -O gpu-app-collection-data_dirs.tgz && \
    tar --skip-old-files -xzvf gpu-app-collection-data_dirs.tgz && \
    rm *.tgz

ENTRYPOINT ["/bin/sleep", "3650d"]
