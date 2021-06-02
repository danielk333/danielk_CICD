#!/usr/bin/env bash

source ./env/bin/activate
cd pyorb
pip install .
pip install .[dev]

cd docsrc
make clean
make html

cp -a build/html/. ../docs
cd ..

coverage run --source=pyorb -m pytest
coverage html
mv ./htmlcov ./docs/htmlcov