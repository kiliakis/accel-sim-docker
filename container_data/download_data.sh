#!/bin/bash


if [ ! -f "./gpu-app-collection-4.2-cuda4.2-gcc4.6.tgz" ]; then 
	echo "Downloading CUDA SDK 4.2"
    wget https://cernbox.cern.ch/index.php/s/Un4OjyBkde48DW9/download -O gpu-app-collection-4.2-cuda4.2-gcc4.6.tgz
fi

if [ ! -f "./gpu-app-collection-bin-cuda4.2-gcc4.6.tgz" ]; then 
	echo "Downloading Compiled Applications"
    wget https://cernbox.cern.ch/index.php/s/BKnV5elkPDgs1nv/download -O gpu-app-collection-bin-cuda4.2-gcc4.6.tgz
fi

if [ ! -f "./gpu-app-collection-data_dirs-cuda4.2-gcc4.6.tgz" ]; then 
	echo "Downloading Application Data"
    wget https://cernbox.cern.ch/index.php/s/XU1XLVfLu8oHRFo/download -O gpu-app-collection-data_dirs-cuda4.2-gcc4.6.tgz
fi

if [ ! -f "./install-cuda4.2-gcc4.6.tgz" ]; then 
	echo "Downloading CUDA 4.2"
    wget https://cernbox.cern.ch/index.php/s/Sw9rsZxuXO4mlpk/download -O install-cuda4.2-gcc4.6.tgz
fi

