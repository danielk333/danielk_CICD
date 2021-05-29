#!/usr/bin/env bash

source ./env/bin/activate
cd package
pip install .
pytest