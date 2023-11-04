#!/bin/bash


container=$(docker ps -a | grep "bd-a1" | awk '{ print $1 }')

user=$(whoami)
workingdirectory=$(pwd)

# -d is for checking if a direcory exists
if [ ! -d $(pwd)/service-result ]; then
    mkdir  $(pwd)/service-result
fi

#to copy the files from cont to host
docker cp   $container:/home/doc-bd-a1/res_dpre.csv service-result/
docker cp   $container:/home/doc-bd-a1/da-in-*.txt service-result/


docker container stop $container
