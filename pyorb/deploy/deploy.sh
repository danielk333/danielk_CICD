#!/usr/bin/env bash

cd package

python3 -m build
python3 -m twine check dist/*
python3 -m twine upload --repository pyorb dist/*