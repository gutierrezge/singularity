# Singularity
This repo is meant to build a docker image with singularity
The docker image is based of ubuntu 22.04 and singularity 4.1.1
This project uses files from [Delfi1](https://bitbucket.org/ipc2018-classical/team23/src/ipc-2018-seq-opt/) team from [IPC 2018 competition](https://ipc2018-classical.bitbucket.io/#planners).

This project has been tested in Linux and MacOS system.

# For the Impatiens
If you are in a hurry to build and run use the following command.

```
docker build . -t singularity && docker run -it --privileged -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro singularity
```

# Build the project
To build the docker image you can use the following command, this could take several minutes, be patient.

```
docker build . -t singularity
```

# Run the project
After the docker image has been build you can run the docker image build run the following command.

```
docker run -it --privileged -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro singularity
```

Please note that you will be inside the container and to use singularity, you can test it by runnin `test.sh` file.

# Testing
Dockerfile creates a simple `test.sh` file that builds and executes a sample planner.
Run the `test.sh` script with the following command, this takes several minutes, be patient.

```
./test.sh
```

# Saving current state
As you may notice, creating the `planner.img` take a long time. If you would like to save the actual state of the docker image to avoid waiting for so long, you can execute the following command. You can do this either while docker is in use or stopped, but this commands runs in the hos machine, this means outside of the actual singularity docker image.

```
docker commit $(docker ps -q --filter ancestor=singularity) singularity
```

# Contribuitors
- Gabriel Gutierrez
- Denis Zelaya
