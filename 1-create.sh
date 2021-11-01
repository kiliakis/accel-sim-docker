version=`cat version.txt`
docker create --privileged --rm \
    	--cpus 0 --gpus all \
	--hostname docker \
	--name accel-sim-$version kiliakis/accel-sim:$version
