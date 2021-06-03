# syntax=docker/dockerfile:1

FROM python:3.7

WORKDIR /src

COPY test.sh test.sh
COPY deploy.sh deploy.sh
COPY doc.sh doc.sh
COPY requirements.txt requirements.txt
COPY dev_requirements.txt dev_requirements.txt

RUN mkdir /src/pyorb
VOLUME /scr/pyorb

RUN python -m venv ./env
RUN ./env/bin/python -m pip install --upgrade pip
RUN ./env/bin/python -m pip install --upgrade pip wheel build twine
RUN ./env/bin/python -m pip install -r requirements.txt
RUN ./env/bin/python -m pip install -r dev_requirements.txt
