# Personal CI/CD

## Setup

Requirements:
 - docker
 - docker-compose
 - bash

1. Install docker by following [docs.docker.com](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).
2. Install docker-compose by following [compose-install](https://docs.docker.com/compose/install/)


## Example

There is an example pipeline in the folder `example`.


## Add new pipeline

1. Create a new folder with the pipeline name
2. Create a `docker-compose.yml` file (template in `template/docker-compose.yml`)
3. Setup the volumes that point to the repository that should be tested and built in the pipeline
4. Create the sub-folders for each testing environment
5. Create a `Dockerfile` in each environment (template in `template/Dockerfile`)
6. Create a `test.sh` file in each environment that describes how to execute and setup the test (template in `template/test.sh`)
7. Create a `deploy.sh` file in the chosen environment folder(s) that describes how to build and deploy (template in `template/deploy.sh`)

To speed up test initiation a `requirements.txt` can be placed in the docker at build, this way only when requirements are changed are the images rebuilt.

## Running the pipeline

The process of compiling the docker and running the pipeline is usually done in two (initially three) steps:

Step 0: Build the images

```bash
docker-compose build
```

Step 1: Run the service and execute the setup and test script. Remember to pass the volume to the image so that the repository from the host is used. For the example called `example`, since the volume is called `pkg` and the target in the `Dockerfile` is `VOLUME /src/package` is the run command is as below.
```bash
docker-compose run -v example_pkg:/src/package deploy bash -e test.sh
```

This can be simplified by putting all of them in a bash script like (in `templates/run.sh`):
```bash
#!/usr/bin/env bash

declare -a servs=("deploy" "test_3_6")

for i in "${servs[@]}"
do
   docker-compose run -v example_pkg:/src/package "$i" bash -e test.sh
done
```

Step 2: Deploy the contents of the repository by executing the deploy script instead in the same way as the test.

```bash
docker-compose run -v example_pkg:/src/package deploy bash -e deploy.sh
```

Then clear the started docker images

```bash
docker-compose down
```