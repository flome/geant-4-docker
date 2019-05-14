# geant-4-docker
Simplified [Geant4](https://geant4.web.cern.ch/) usage with a [Docker container](https://cloud.docker.com/repository/docker/smflment/geant-4-docker/general) derived from a [Ubuntu 16.04 ROOT](https://hub.docker.com/r/rootproject/root-ubuntu16/) container.

Docker can be installed following the instructions on the [Docker homepage](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## Usage

To run the container, simply call
```
docker run -it --rm --name geant4_container geant4 bash
```
Options:
- ``` -it ```: Keep bash open after invoking
- ``` --rm ```: Delete container when stopping. Remove this option if you want to keep your container for more than one session
- ``` --name geant4_container```: Name for your container.

### GUI

To use the GUI, you need to pass X11 information. From Linux you can run the container using
```
docker run -it --rm --ipc=host --net=host \
           -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
           geant4 bash
```
### Run example

A simple test can be performed using a simple example within the container:
```
cp -r $G4EXAMPLES/basic/B1 ./ && cd B1/ && mkdir build && cd build && cmake ../ && make && ./exampleB1
```

## Bare image

The bare image comes without examples and datasets. You will need to download them yourself in that case and provide them using a volume adding the option
```
-v path/to/unpacked/datasets:/usr/local/geant4/share/Geant4-10.5.1/data
```

- [G4NDL.4.5](https://cern.ch/geant4-data/datasets/G4NDL.4.5.tar.gz)
- [G4EMLOW.7.7](https://cern.ch/geant4-data/datasets/G4EMLOW.7.7.tar.gz)
- [G4PhotonEvaporation.5.3](https://cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.3.tar.gz)
- [G4RadioactiveDecay.5.3](https://cern.ch/geant4-data/datasets/G4RadioactiveDecay.5.3.tar.gz)
- [G4PARTICLEXS.1.1](https://cern.ch/geant4-data/datasets/G4PARTICLEXS.1.1.tar.gz)
- [G4PII.1.3](https://cern.ch/geant4-data/datasets/G4PII.1.3.tar.gz)
- [G4RealSurface.2.1.1](https://cern.ch/geant4-data/datasets/G4RealSurface.2.1.1.tar.gz)
- [G4SAIDDATA.2.0](https://cern.ch/geant4-data/datasets/G4SAIDDATA.2.0.tar.gz)
- [G4ABLA.3.1](https://cern.ch/geant4-data/datasets/G4ABLA.3.1.tar.gz)
- [G4INCL.1.0](https://cern.ch/geant4-data/datasets/G4INCL.1.0.tar.gz)
- [G4ENSDFSTATE.2.2](https://cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.2.tar.gz)
