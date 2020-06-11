#!/bin/bash

echo "starting VNC server ..."
#export USER=user
#export PATH=$USER/scripts:$PATH
vncpass.sh $VNCPASS
vncserver -kill :1
vncserver :1 -geometry 1366x768 -depth 24

