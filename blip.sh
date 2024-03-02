#! /bin/bash

if [ -z "$EDITOR" ]; then
    echo "The EDITOR variable is not set. Please set the EDITOR environment variable and try again."
    exit 1
fi

DATE=$(date +%F)
TIME=$(date +%T | tr -d ':')
FILE_NAME=$DATE\_$TIME.md
hugo new blip/$FILE_NAME
$EDITOR content/blip/$FILE_NAME