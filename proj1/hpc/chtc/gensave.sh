#!/bin/bash
set -e

# Matthew Dorsey
# 2022-10-05

# script that copies save files from the most recent iteration of an annealing simulation
# as files the will be transfered to the execute node of the next iteration of the 
# annealing simulation

## ARGUMENTS 
# first argument: id associated with batch of annealing simulations
JOB=$1
# first argument: id associated with the annealing simulation
SIMID=$2
# second argument: integer associated with the iteration of the annealing simulation
INT=$3

## PARAMETERS
# formatted integer for file writing
INTSTRING=$(printf '%03d' $INT)

## FUNCTIONS
# none

## SCRIPT

# save files from the most iteration of the annealing simulation
SAVEPOSINT="${JOB}${SIMID}_${INTSTRING}__fposSAVE.dat"
SAVEVELINT="${JOB}${SIMID}_${INTSTRING}__velSAVE.dat"
SAVECHAIINT="${JOB}${SIMID}_${INTSTRING}__chaiSAVE.dat"
SAVEANNINT="${JOB}${SIMID}_${INTSTRING}__annSAVE.dat"
SAVESIMINT="${JOB}${SIMID}_${INTSTRING}__simSAVE.dat"

# save files transfered to the execute nodee by submit file
SAVEPOS="${JOB}${SIMID}__fposSAVE.dat"
SAVEVEL="${JOB}${SIMID}__velSAVE.dat"
SAVECHAI="${JOB}${SIMID}__chaiSAVE.dat"
SAVEANN="${JOB}${SIMID}__annSAVE.dat"
SAVESIM="${JOB}${SIMID}__simSAVE.dat"

# copy the files from the most recent iteration to the transfer files for the next job
cp "save/${SAVEPOSINT}" "save/${SAVEPOS}"
cp "save/${SAVEVELINT}" "save/${SAVEVEL}"
cp "save/${SAVECHAIINT}" "save/${SAVECHAI}"
cp "save/${SAVEANNINT}" "save/${SAVEANN}"
cp "save/${SAVESIMINT}" "save/${SAVESIM}"
