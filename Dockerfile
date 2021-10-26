FROM ubuntu:18.04

USER root
WORKDIR /root

# COPY setup_torque.sh /root/
COPY finalize_installation.sh .bashrc /root/
# COPY .bashrc /root/

ENV CUDA_INSTALL_PATH="/root/install/cuda" \
    PATH="/root/install/cuda/bin:/usr/bin:/usr/local/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:"

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qq update \
  && apt-get install  -y build-essential xutils-dev bison zlib1g-dev flex htop \
      libglu1-mesa-dev git g++ curl gdb libssl-dev libxml2-dev libboost-all-dev \
      freeglut3 freeglut3-dev gfortran scons zip\
      software-properties-common \
      vim python-setuptools python-dev python-pip \
  && pip install pyyaml==5.1 \
  && wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda_11.0.1_450.36.06_linux.run \
  && sh cuda_11.0.1_450.36.06_linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-11 --samples --samplespath=/root/ \
  && rm cuda_11.0.1_450.36.06_linux.run \
  && wget http://developer.download.nvidia.com/compute/cuda/4_2/rel/toolkit/cudatoolkit_4.2.9_linux_64_ubuntu11.04.run

RUN add-apt-repository -y 'deb http://archive.ubuntu.com/ubuntu/ trusty main' && \
    add-apt-repository -y 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' && \
    apt-get install -y gcc-4.6 g++-4.6
    # update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 60 && \
    # update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 60


RUN cd /root && git clone https://github.com/accel-sim/accel-sim-framework.git && \
    cd accel-sim-framework/gpu-simulator && \
    git clone --branch=dev https://github.com/accel-sim/gpgpu-sim_distribution.git gpgpu-sim &&\
    ln -s /root/accel-sim-framework/gpu-simulator/gpgpu-sim /root/gpgpu-sim && \
    cd /root && git clone https://github.com/accel-sim/gpu-app-collection && \
    cd /root/ && git clone --branch=gpusim https://github.com/kiliakis/config.git && \
    cd config && cp -r .vim .vimrc .gitconfig .git-* /root/ 


    # cd /root/accel-sim-framework
    # ./util/tracer_nvbit/install_nvbit.sh && \
    # make -C ./util/tracer_nvbit/

# RUN cd /root/accel-sim-framework && bash ./gpu-simulator/setup_environment.sh && \
    # ln -s /root/accel-sim-framework/gpu-simulator/gpgpu-sim /root/gpgpu-sim
# && \
    # make -j -C ./gpu-simulator/

# RUN cd /root && git clone https://github.com/accel-sim/gpu-app-collection 
# && \
    # cd gpu-app-collection 
    # && bash ./src/setup_environment
    # make all -i -j -C ./src && \
    # make data

# RUN cd /root/ && git clone --branch=gpusim https://github.com/kiliakis/config.git && \
#     cd config && \
#     cp -r .vim .vimrc .gitconfig .git-* /root/ 

ENTRYPOINT ["/bin/sleep", "365d"]


# install packages
# RUN apt-get update -y && apt-get install -yq build-essential apt-utils wget vim htop \
#     software-properties-common xutils-dev build-essential bison \
#     zlib1g-dev flex libglu1-mesa-dev binutils-gold libboost-system-dev \
#     libboost-filesystem-dev libopenmpi-dev openmpi-bin libopenmpi-dev \
#     gfortran torque-server torque-client torque-mom torque-pam \
#     freeglut3 freeglut3-dev git curl python python-pip psmisc sudo \
#     libssl-dev

# RUN useradd -ms /bin/bash kiliakis && echo "kiliakis:kiliakis" | chpasswd && passwd -d kiliakis && \
#     adduser --disabled-password kiliakis sudo && \
#     echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER kiliakis
# WORKDIR /home/kiliakis

# RUN mkdir /home/kiliakis/git && mkdir /home/kiliakis/install && mkdir /home/kiliakis/simulations-gpgpu

# RUN cd /home/kiliakis/install && wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh && \
#     bash miniconda.sh -b -p /home/kiliakis/install/miniconda2 && \
#     echo "export PATH=/home/kiliakis/install/miniconda2/bin:$PATH" >> /home/kiliakis/.bashrc
# # python2 -m pip install cycler pyyaml numpy
# # make directories
# # RUN mkdir /home/kiliakis/git && mkdir /home/kiliakis/install && mkdir /home/kiliakis/simulations-gpgpu

# # copy data
# COPY --chown=kiliakis:kiliakis data/gpgpusim-vm-data/install /home/kiliakis/install/
# COPY --chown=kiliakis:kiliakis data/gpgpusim-vm-data/simulations-gpgpu /home/kiliakis/simulations-gpgpu/


# # python-pip python-dev
# # install python packages
# # RUN add-apt-repository ppa:deadsnakes/ppa && \
# # apt-get update -y && \
# # apt-get -yq install python3.7

# # cd /home/kiliakis/install && curl https://bootstrap.pypa.io/pip/3.4/get-pip.py -o get-pip.py && \
# #     python3 get-pip.py --user && \
# #     python3 -m pip install --user pyyaml numpy cycler


# #RUN cd git && git clone https://github.com/NVIDIA/cuda-samples.git cuda-11.2-samples && \
# #    cd cuda-11.2-samples && git checkout -b v11.2

# # install dot files
# RUN cd /home/kiliakis/git && git clone --branch=gpusim https://github.com/kiliakis/config.git && cd config && \
# cp -r .bashrc .vim .vimrc .gitconfig .git-* /home/kiliakis/ 
# # source /home/kiliakis/.bashrc

# #install cuda
# COPY --chown=kiliakis:kiliakis data/gpgpusim-vm-data/cuda_9.0.176_384.81_linux-run /home/kiliakis/install/

# RUN cd /home/kiliakis/install && sudo sh cuda_9.0.176_384.81_linux-run --silent --override --samples --samplespath=/home/kiliakis/ --toolkit --toolkitpath=/usr/local/cuda-9.0

# # ENV SERVER="ubuntu"


# # torque set-up
# # RUN sudo /etc/init.d/torque-mom stop && \
# #     sudo /etc/init.d/torque-scheduler stop && \
# #     sudo /etc/init.d/torque-server stop && \
# #     sudo pbs_server -f -t create && \
# #     sudo killall pbs_server && \
# #     sudo echo "172.17.0.3 ubuntu.local" >> /etc/hosts && \
# #     sudo echo "ubuntu.local" > /etc/torque/server_name && \
# #     sudo echo "ubuntu.local" > /var/spool/torque/server_priv/acl_svr/acl_hosts && \
# #     sudo echo "root@ubuntu.local" > /var/spool/torque/server_priv/acl_svr/operators && \
# #     sudo echo "root@ubuntu.local" > /var/spool/torque/server_priv/acl_svr/managers && \
# #     sudo echo "ubuntu.local np=40" > /var/spool/torque/server_priv/nodes && \
# #     sudo echo "ubuntu.local" > /var/spool/torque/mom_priv/config && \
# #     sudo /etc/init.d/torque-server start && \
# #     sudo /etc/init.d/torque-scheduler start && \
# #     sudo /etc/init.d/torque-mom start && \
# #     sudo qmgr -c 'set server scheduling = true' && \
# #     sudo qmgr -c 'set server keep_completed = 60' && \
# #     sudo qmgr -c 'set server mom_job_sync = true' && \
# #     sudo qmgr -c 'create queue batch' && \
# #     sudo qmgr -c 'set queue batch queue_type = execution' && \
# #     sudo qmgr -c 'set queue batch started = true' && \
# #     sudo qmgr -c 'set queue batch enabled = true' && \
# #     sudo qmgr -c 'set queue batch resources_default.walltime = 1:00:00' && \
# #     sudo qmgr -c 'set queue batch resources_default.nodes = 1' && \
# #     sudo qmgr -c 'set server default_queue = batch' && \
# #     sudo qmgr -c 'set server submit_hosts = ubuntu' && \
# #     sudo qmgr -c 'set server allow_node_submit = true'
# COPY --chown=kiliakis:kiliakis data/gpgpusim-vm-data/setup-torque.sh /home/kiliakis/

# RUN mkdir /home/kiliakis/.ssh
# COPY --chown=kiliakis:kiliakis data/gpgpusim-vm-data/.ssh/* /home/kiliakis/.ssh/
# # RUN sudo chown -R kiliakis:kiliakis /home/kiliakis/.ssh

# RUN cd /home/kiliakis && git clone git@github.com:kiliakis/gpgpu-sim.git
# # cd gpgpu-sim && \
# # /bin/bash -c "source setup_environment" && \
# # make -j
# RUN echo "export PATH=/home/kiliakis/install/miniconda2/bin:$PATH" >> /home/kiliakis/.bashrc && \
#     export PATH=/home/kiliakis/install/miniconda2/bin:$PATH && \
#     python -m pip install pyyaml cycler numpy




# setup gcc versions
# RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 && \
# update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 50 && \
# update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 60 && \
# update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 50 && \
# update-alternatives --set gcc /usr/bin/gcc-4.9 && \
# update-alternatives --set g++ /usr/bin/g++-4.9 

# append variables to the bashrc
# RUN echo "export PATH=/usr/local/cuda/bin:$PATH" >> /root/.bashrc && \
# echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64" >> $HOME/.bashrc && \
# echo "export RTE_SDK=$HOME/install/dpdk-16.11/build" >> $HOME/.bashrc

# setup dpdk
# RUN cd $HOME/install && tar -xzvf dpdk-16.11.tar.gz && \
# cd dpdk-16.11 &&  make config T=x86_64-native-linuxapp-gcc && \
# make RTE_KERNELDIR=/lib/modules/4.4.0-194-generic/build && \
# ln -s $HOME/install/dpdk-16.11/mk $HOME/install/dpdk-16.11/build/mk && \
# ln -s $HOME/install/dpdk-16.11/build $HOME/install/dpdk-16.11/build/x86_64-native-linuxapp-gcc

# setup cuda sdk
# RUN cd $HOME/install && sh cuda_6.5.14_linux_64.run -silent --override --toolkit --samples && \
#ln -s /usr/local/cuda-6.5 /usr/local/cuda && \
#/usr/local/cuda/bin/nvcc --version

# RUN cd $HOME/install && sh cuda_10.1.105_418.39_linux.run --silent --samples --samplespath=/usr/local/cuda-10.1/ && \
# ln -s /usr/local/cuda-10.1 /usr/local/cuda

# setup megakv    
# RUN cd $HOME/git && git clone https://github.com/pzrq/megakv.git && \
# update-alternatives --set gcc /usr/bin/gcc-4.8 && \
# update-alternatives --set g++ /usr/bin/g++-4.8

# RUN export PATH=/usr/local/cuda/bin:$PATH && \
# export LD_LIBRARY_PATH=/usr/local/cuda/lib64 && \
# export RTE_SDK=$HOME/install/dpdk-16.11/build && \
# cd $HOME/git/megakv/libgpuhash && make && cd $HOME/git/megakv/src && make
