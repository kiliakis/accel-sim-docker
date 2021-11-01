#!/bin/bash

if [ ! -d $HOME/gpu-app-collection/4.2 ]; then 
	echo "Building GPU SDK-4.2"
	cd $HOME/gpu-app-collection
	source ./src/setup_environment
fi

if [ ! -d $HOME/gpu-app-collection/bin ]; then 
	echo "Building Applications"
	cd $HOME/gpu-app-collection
	source ./src/setup_environment
	make all -i -j -C ./src
fi

if [ ! -d $HOME/gpu-app-collection/data_dirs ]; then 
	echo "Getting the data"
	cd $HOME/gpu-app-collection
	source ./src/setup_environment
	make data
fi

echo "Builing gpgpu-sim"
cd $HOME/gpgpu-sim
git checkout dev
source setup_environment
make -j
