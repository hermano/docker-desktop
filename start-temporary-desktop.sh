#!/bin/bash

docker run --rm -ti -p 5901:5901 -p 6081:6081 --privileged=true --security-opt seccomp:unconfined --device /dev/dri -v /dev/shm:/dev/shm stripped-desktop
