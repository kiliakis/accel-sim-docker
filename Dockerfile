FROM ubuntu:18.04

USER root
WORKDIR /root

COPY container_data/* /root/

ENV CUDA_INSTALL_PATH="/root/install/cuda" \
    PATH="/root/install/cuda/bin:/usr/bin:/usr/local/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:"

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get -qq update && \
    apt-get install  -y build-essential xutils-dev bison zlib1g-dev flex htop \
        libglu1-mesa-dev git g++ curl gdb libssl-dev libxml2-dev libboost-all-dev \
        freeglut3 freeglut3-dev gfortran scons zip\
        software-properties-common \
        vim python-setuptools python-dev python-pip && \
    add-apt-repository -y 'deb http://archive.ubuntu.com/ubuntu/ trusty main' && \
    add-apt-repository -y 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' && \
    apt-get update && \
    apt-get install -y gcc-4.6 g++-4.6 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 50 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 50 && \
    pip install pyyaml==5.1 && \
    wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda_11.0.1_450.36.06_linux.run && \
    sh cuda_11.0.1_450.36.06_linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-11 --samples --samplespath=/root/ && \
    rm cuda_11.0.1_450.36.06_linux.run && \
    wget http://developer.download.nvidia.com/compute/cuda/4_2/rel/toolkit/cudatoolkit_4.2.9_linux_64_ubuntu11.04.run

RUN cd /root && git clone https://github.com/accel-sim/accel-sim-framework.git && \
    cd accel-sim-framework/gpu-simulator && \
    git clone --branch=dev https://github.com/accel-sim/gpgpu-sim_distribution.git gpgpu-sim &&\
    ln -s /root/accel-sim-framework/gpu-simulator/gpgpu-sim /root/gpgpu-sim && \
    cd /root && git clone https://github.com/accel-sim/gpu-app-collection && \
    cd /root/ && git clone --branch=gpusim https://github.com/kiliakis/config.git && \
    cd config && cp -r .vim .vimrc .gitconfig .git-* /root/ 

RUN cd /root && mkdir install && \
    tar --skip-old-files -xzvf gpu-app-collection-bin-cuda4.2-gcc4.6.tgz && \
    tar --skip-old-files -xzvf gpu-app-collection-data_dirs-cuda4.2-gcc4.6.tgz && \
    tar --skip-old-files -xzvf gpu-app-collection-4.2-cuda4.2-gcc4.6.tgz && \
    tar --skip-old-files -xzvf install-cuda4.2-gcc4.6.tgz && \
    rm *.tgz

ENTRYPOINT ["/bin/sleep", "3650d"]
