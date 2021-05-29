#!/usr/bin/env bash


case "$1" in

build)
    echo "Preparing pipeline..."

    if [ -d "pyorb" ]; then
        echo "File exists"
    else 
        echo "Repository not fetched, cloning..."
        git clone git@github.com:danielk333/pyorb.git
    fi 

    cd pyorb

    if [ -z "$2" ]
    then
        echo "using branch $2"
        git checkout "$2"
    else
        echo "Using branch master"
        git checkout master
    fi
    
    git pull
    cd ..

    cp pyorb/requirements deploy/requirements.txt

    docker-compose build

    ;;
test) 
    docker-compose run -v pyorb_pkg:/src/pyorb deploy bash -e test.sh
    docker-compose down
    ;;
pypi) 
    docker-compose run -v pyorb_pkg:/src/pyorb deploy bash -e deploy.sh
    docker-compose down
    ;;
*) echo "Command not found, exiting"
   ;;
esac



