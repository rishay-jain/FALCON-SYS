#!/bin/bash

# Root project folder
PROJECT_NAME="FALCON_SYS"

echo "Creating project structure for $PROJECT_NAME ..."

mkdir -p $PROJECT_NAME/{docs,ros_ws/src,scripts,config,data}

# Inside ros_ws create empty README.md and initialize workspace marker files
touch $PROJECT_NAME/README.md
touch $PROJECT_NAME/ros_ws/src/.gitkeep

echo "Folder structure created under $(pwd)/$PROJECT_NAME"


