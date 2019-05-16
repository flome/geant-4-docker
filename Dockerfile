FROM smflment/cern-root:6-16
USER root

RUN apt-get update -y -qq ;\
    apt-get install --no-install-recommends -qq -y \
    wget cmake make g++ libxerces-c-dev qt4-dev-tools \
    freeglut3-dev libmotif-dev libxpm-dev libxmu-dev libxi-dev &&\
    apt-get autoremove -y

# RUN apt-get install -y tk-dev 

WORKDIR /tmp

RUN wget http://cern.ch/geant4-data/releases/geant4.10.05.p01.tar.gz &&\
    tar -xzf "geant4.10.05.p01.tar.gz" &&\
    mv "geant4.10.05.p01" geant4 &&\
    rm "geant4.10.05.p01.tar.gz" 

WORKDIR /tmp/geant4-build
RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=/usr/local/geant4 \
          -DGEANT4_INSTALL_DATA=ON \
          -DGEANT4_USE_SYSTEM_CLHEP=OFF \
          -DGEANT4_USE_SYSTEM_EXPAT=OFF \
          -DGEANT4_USE_GDML=ON \
          -DGEANT4_USE_OPENGL_X11=ON \
          -DGEANT4_USE_QT=ON \
          -DGEANT4_USE_XM=ON \
          ../geant4 ;\ 
    make -j4 ;\
    make install ;\
    cd ..;\
    rm -rf geant4 geant4-build


WORKDIR /tmp
COPY ./geant4.entrypoint.sh /
RUN chmod +x /geant4.entrypoint.sh

ENTRYPOINT [ "/geant4.entrypoint.sh" ]
