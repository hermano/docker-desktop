#!/bin/bash

echo "starting VNC server ..."
export USER=root
vncserver :1 -geometry 1024x800 -depth 24 # && tail -F /root/.vnc/*.log
