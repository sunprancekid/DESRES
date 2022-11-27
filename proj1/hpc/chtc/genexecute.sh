#!/bin/bash
set -e

# Matthew Dorsey
# 2022-08_03

# generates executable that the submitfile exectues on the execute node throuh HTCondor

## ARGUMENTS
# first argument: id associated with annealing simulation
SIMID=$1
# second argument: path and directory where annealing simulation files are stored
DIRECTORY=$2

## PARAMETERS
# gfortran compiler execution
GFORT="gfortran -O"
# ifort compiler execution + flags
IFORT="ifort -no-wrap-margin -O3 -fp-model=precise"
# file that contains executable
EXECUTE="${DIRECTORY}/exec/${SIMID}.sh"

## SCRIPT
echo "generating ${EXECUTE}"
echo "${GFORT} $SIMID.f90" > $EXECUTE
echo "./a.out" >> $EXECUTE
chmod u+x $EXECUTE

