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
        echo "Using branch master"
        git checkout master
    else
        echo "using branch $2"
        git checkout "$2"
    fi
    
    git pull
    cd ..

    cp pyorb/requirements deploy/requirements.txt
    cp pyorb/dev_requirements deploy/dev_requirements.txt

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
bash) 
    docker-compose run -v pyorb_pkg:/src/pyorb deploy bash
    docker-compose down
    ;;
down) 
    docker-compose down
    ;;
clean) 
    sudo rm -rv pyorb
    ;;
docs)
    cd pyorb

    if [ -z "$3" ]
    then
        echo "merging from branch master"
        git checkout master
    else
        echo "merging from branch $3"
        git checkout "$3"
    fi
    git pull

    if [ -z "$2" ]
    then
        echo "Using branch master"
        git checkout gh-pages
    else
        echo "using branch $2"
        git checkout "$2"
    fi

    if [ -z "$3" ]
    then
        echo "merging from branch master"
        git merge master
    else
        echo "merging from branch $3"
        git merge "$3"
    fi

    echo "Removing old docs..."
    sudo rm -rv ./docs
    mkdir docs
    sudo rm -rv ./docsrc/build/*
    sudo rm -rv ./docsrc/source/_autodoc/
    sudo rm -rv ./docsrc/source/auto_gallery/

    cd ..
    
    echo "Building new docs..."

    docker-compose run -v pyorb_pkg:/src/pyorb deploy bash -e doc.sh
    ;;
*)
    echo "Command not found, exiting"
    ;;
esac
