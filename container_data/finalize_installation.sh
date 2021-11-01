#!/bin/bash

if [ ! -d $HOME/install/cuda/bin ]; then
	echo "Building CUDA-11"
	cd $HOME
	sh cuda_11.0.1_450.36.06_linux.run --silent --toolkit --toolkitpath=/root/install/cuda
	sh cuda_11.0.1_450.36.06_linux.run --silent --samples --samplespath=/root/install/cuda
fi

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

