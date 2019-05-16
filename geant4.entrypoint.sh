#!/bin/bash
set -e
source /usr/local/geant4/bin/geant4.sh
source /usr/local/root-6.16.00/bin/thisroot.sh

export G4COMP=/usr/local/geant4/lib/Geant4-10.5.1
export G4INSTALL=/usr/local/geant4
export G4EXAMPLES=/usr/local/geant4/share/Geant4-10.5.1/examples

export XAUTHORITY=/root/.Xauthority 

exec "$@"