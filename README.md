# geant-4-docker
Simplified [Geant4](https://geant4.web.cern.ch/) usage with a [Docker container](https://cloud.docker.com/repository/docker/smflment/geant-4-docker/general) derived from a [Ubuntu 16.04 ROOT](https://hub.docker.com/r/rootproject/root-ubuntu16/) container.

Docker can be installed following the instructions on the [Docker homepage](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

To use the GUI, you need to pass X11 information. From Linux you can run the container using
```
docker run -it --rm --ipc=host --net=host \
           -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
           geant4 bash
```
