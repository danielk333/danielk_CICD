# syntax=docker/dockerfile:1

FROM python:3.7

WORKDIR /src

COPY test.sh test.sh
COPY deploy.sh deploy.sh

RUN mkdir /src/pyorb
VOLUME /scr/pyorb

RUN python -m venv ./env
RUN ./env/bin/python -m pip install --upgrade pip
RUN ./env/bin/python -m pip install -r requirements.txt
RUN ./env/bin/python -m pip install --upgrade wheel
RUN ./env/bin/python -m pip install --upgrade pytest
RUN ./env/bin/python -m pip install --upgrade build
RUN ./env/bin/python -m pip install --upgrade twine