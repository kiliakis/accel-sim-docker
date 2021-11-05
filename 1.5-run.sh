version=`cat version.txt`
docker run --privileged --hostname docker \
	--cpus 0 -ti --rm \ 
	--name accel-sim-$version kiliakis/accel-sim:$version
