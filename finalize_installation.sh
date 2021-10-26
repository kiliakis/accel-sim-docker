#!/bin/bash

echo "installing cuda"
cd $HOME
mkdir install
bash cudatoolkit_4.2.9_linux_64_ubuntu11.04.run


echo "Builing gpgpu-sim"
cd $HOME/gpgpu-sim
git checkout dev
source setup_environment
make -j

echo "Builing the applications"
cd $HOME/gpu-app-collection
source ./src/setup_environment
make all -i -C ./4.2
make all -i -j -C ./src
make data
