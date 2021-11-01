version=`cat version.txt`
docker run --privileged --hostname docker \
	--cpus 0 --gpus all -ti --rm \ 
	--name accel-sim-$version kiliakis/accel-sim:$version
