#!/usr/bin/env bash

podman run --rm -p8888:8888 -v$HOME/Development/sagebooks:/home/sage/sagebooks:z --userns keep-id --name sage sagemath/sagemath:10.8 sage-jupyter
