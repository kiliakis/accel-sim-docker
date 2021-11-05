version=`cat version.txt`

docker build -t kiliakis/accel-sim:$version .
