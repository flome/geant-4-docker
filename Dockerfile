FROM rootproject/root-ubuntu16
USER root

RUN apt-get update -y -qq ;\
    apt-get install --no-install-recommends -qq -y \
    wget cmake make g++ libxerces-c-dev qt5-default \
    libqt5opengl5-dev software-properties-common &&\    
    add-apt-repository ppa:ubuntu-x-swat/updates && \
    apt-get update && apt-get -y dist-upgrade &&\
    apt-get autoremove -y

WORKDIR /tmp
COPY geant4.10.05.p01.tar.gz .
RUN tar -xzf "geant4.10.05.p01.tar.gz" ;\
    mv "geant4.10.05.p01" geant4 ;\
    rm "geant4.10.05.p01.tar.gz" 

WORKDIR /tmp/geant4-build
RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=/usr/local/geant4 \
          -DGEANT4_INSTALL_DATA=OFF \
          -DGEANT4_USE_SYSTEM_CLHEP=OFF \
          -DGEANT4_USE_SYSTEM_EXPAT=OFF \
          -DGEANT4_USE_GDML=ON \
          -DGEANT4_USE_OPENGL_X11=ON \
          -DGEANT4_USE_QT=ON \
          ../geant4 ;\ 
    make -j4 ;\
    make install ;\
    cd ..;\
    rm -rf geant4 geant4-build

RUN apt-get install -y 

WORKDIR /tmp
COPY ./geant4.entrypoint.sh /tmp
RUN chmod +x /tmp/geant4.entrypoint.sh

ENTRYPOINT [ "/tmp/geant4.entrypoint.sh" ]
