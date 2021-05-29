#!/usr/bin/env bash

declare -a servs=("deploy" "test-3-6")

for i in "${servs[@]}"
do
   docker-compose run -v example_pkg:/src/package "$i" bash -e test.sh
done

