# syntax=docker/dockerfile:1

FROM python:3.7-buster

WORKDIR /src

COPY test.sh test.sh
COPY requirements.txt requirements.txt

RUN mkdir /src/package
VOLUME /scr/package

RUN python -m venv ./env
RUN ./env/bin/python -m pip install --upgrade pip
RUN ./env/bin/python -m pip install --upgrade wheel
RUN ./env/bin/python -m pip install -r requirements.txt