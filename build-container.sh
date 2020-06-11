#!/bin/bash

tar -cvzf user-home.tar.gz -C user/ $(ls -A1 user/)
tar -cvzf root-home.tar.gz -C root/ $(ls -A1 root/)
docker build -t stripped-desktop  .
