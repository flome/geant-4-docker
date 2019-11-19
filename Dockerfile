FROM smflment/cern-root:6-16
USER root

RUN apt-get update -y -qq ;\
    apt-get install --no-install-recommends -qq -y \
    # basics not installed by root already
    make \
    # xml parser for geant4
    libxerces-c-dev \
    # visualizer libraries
    qt4-dev-tools \
    libgl1-mesa-dev \
    libxmu-dev \
    libxi-dev \
    libmotif-dev &&\
    # clean up image
    apt-get autoremove -y 

RUN dpkg-reconfigure locales;

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
          -DGEANT4_BUILD_MULTITHREADED=ON \
          ../geant4 ;\ 
    make -j4 ;\
    make install ;\
    cd ..;\
    rm -rf geant4 geant4-build


WORKDIR /tmp
RUN mkdir geant4run

COPY ./geant4.entrypoint.sh /
RUN chmod +x /geant4.entrypoint.sh

ENTRYPOINT [ "/geant4.entrypoint.sh" ]
