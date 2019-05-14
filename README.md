# geant-4-docker
Simplified Geant4 usage with a docker container derived from a Ubuntu 16.04 ROOT container.

Docker can be installed following the instructions on the [Docker homepage](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

To use the GUI, you need to pass X11 information. From Linux you can run the container using
```
docker run -it --rm --ipc=host --net=host \
           -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
           geant4 bash
```
