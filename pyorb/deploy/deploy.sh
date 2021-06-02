#!/usr/bin/env bash

source ./env/bin/activate
cd pyorb

python3 -m build
python3 -m twine check dist/*
python3 -m twine upload dist/*