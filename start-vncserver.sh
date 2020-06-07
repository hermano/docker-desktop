#!/bin/bash

echo "starting VNC server ..."
export USER=root
vncserver :1 -geometry 1024x576 -depth 24 # && tail -F /root/.vnc/*.log
