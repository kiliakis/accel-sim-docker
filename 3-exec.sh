version=`cat version.txt`
docker exec -ti -e COLUMNS=$COLUMNS -e LINES=$LINES accel-sim-$version /bin/bash
