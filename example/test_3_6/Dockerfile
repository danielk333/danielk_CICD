# syntax=docker/dockerfile:1

FROM python:3.6

WORKDIR /src

COPY test.sh test.sh

RUN mkdir /src/package
VOLUME /scr/package

RUN python -m venv ./env
RUN ./env/bin/python -m pip install --upgrade pip
RUN ./env/bin/python -m pip install --upgrade wheel