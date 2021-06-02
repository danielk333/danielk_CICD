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

    if [ -e "../.pypirc" ]; then
        echo "PyPI RC exists, cloning to pyorb"
        cp ../.pypirc ./pyorb/.pypirc
    else 
        echo "No PyPI RC found"
    fi 

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
ghpages)
    cd pyorb

    if [ -z "$2" ]
    then
        echo "using branch $2"
        git checkout "$2"
    else
        echo "Using branch master"
        git checkout gh-pages
    fi

    if [ -z "$3" ]
    then
        echo "merging from branch $3"
        git merge "$3"
    else
        echo "merging from branch master"
        git merge master
    fi

    echo "Removing old docs..."
    rm -r ./docs/*
    rm -r ./docsrc/build/*
    rm -r ./docsrc/source/_autodoc/
    rm -r ./docsrc/source/auto_gallery/
    
    echo "Building new docs..."

    docker-compose run -v pyorb_pkg:/src/pyorb deploy bash -e doc.sh

    git push

*) echo "Command not found, exiting"
   ;;
esac



