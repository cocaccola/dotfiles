#!/bin/bash

instance=$1

if [[ -z $instance ]]; then
    echo "you must supply an instance name" >&2
    exit 2
fi

gcloud compute ssh $instance --ssh-flag="-fNT" --ssh-flag="-L 2222:localhost:22"
