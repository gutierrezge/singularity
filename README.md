# singularity
Code repo to have a docker image of singularity

# How to build and run

## Just using docker
If you like to run without using docker-compose, use the following command
```
docker build . -t singularity && docker run -it --privileged \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    singularity
```

## Using docker-compose
Please note that docker-compose does not allow proper terminal interaction. Use this option when you want to have a script that runs all steps you want whenever the container starts. You add this script using COPY command in the Dockerfile and use the CMD to run the desired script. This is not an error, this is the nature of how docker-compose behave.

```
docker-compose build && docker-compose up
```

# Testing
Dockerfile creates a simple `test.sh` file that builds and executes a planner. This step takes between 5 to 10 minutes to execute.

Inside the container, run the `test.sh` script with the following command

```
./test.sh
```

# Contribuitors
- Gabriel Gutierrez
- Denis Zelaya
