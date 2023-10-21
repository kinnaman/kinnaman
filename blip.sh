#! /bin/bash

DATE=$(date +%F)
TIME=$(date +%T)
FILE_NAME=$DATE\_$TIME.md
hugo new blip/$FILE_NAME
$EDITOR content/blip/$FILE_NAME
