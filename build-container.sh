#!/bin/bash

tar -cvzf student-home.tar.gz home
docker build -t stripped-desktop .
