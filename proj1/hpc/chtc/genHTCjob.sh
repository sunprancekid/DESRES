#!/bin/bash
set -e

# Matthew Dorsey
# 2022-09-29
# polsqu
# Script generates directories of annealing simulations on chtc systems.
# The directory hierarchy is organized by square model, type of dipole, number fraction
# of A chirality squares, and then density. The simulation is executed from the density
# subdirectory and contains all of the associated files. 


# Files associated with each simulation are stored within subdirectories titled after the simulations ID.
# The job is submitted to HTCondor through DAG files.
# Each simulation has a DAG file stored within its subdirectory that lists the number of temperature steps that should occur.
# The main DAG file is stored within the main directory, and splices the sub-dags, pointing DAGman to the appropriate subdirectory.
# NOTE: This file will very for each job submission, based on the simulation variables and parameters.

## ARGUMENTS
# first argument: title of job
JOB=$1
# second argument: density of simulation 
ETA=$2

## PARAMETERS
# array containing simulation parameters: type of square (2x2, or 3x3)
SQUARE="2"
# array containing simulation parameters: type of dipole embedded in square
DIPOLE="A"
# array containing simulation parameters: the number fractions
NUMFRAC="10"
# array containing simulation parameters: density
#ETA=( "65" )
# number of events in an annealing simulation step (* E^7)
EVENTS=( "10" "15" "20" "25" "30")
# fraction by which to reduced the temperature during an annealing simulation
ANNEALFRAC=( "91" "92" "93" "94" "95" "96" "97" "98" )

## FUNCTIONS 
# none

## SCRIPT

# generate the simulation hierarchy by looping through variables
# the gensimulation scripts accepts the simulation's id, the number of temperature steps the annealing simulation, and any other variables / parameters.

# program that echos compile-time simulation program
ECHOPROGRAM="./simbin/dmd/echoprogram_${SQUARE}x${SQUARE}stan.sh"
for v1 in ${ETA[@]}; do
    
    # establish the first directory
    FIRSTDIRECTORY="e${v1}"
    
    # establish DAG file
    DAG="${JOB}${FIRSTDIRECTORY}.dag"
    if [ -f $DAG ]; then
        rm $DAG
    fi
    
    for v2 in ${EVENTS[@]}; do
    
        # establish the second directory
        SECONDDIRECTORY="N${v2}"
        
        for v3 in ${ANNEALFRAC[@]}; do
        
            # establish the third directory
            THIRDDIRECTORY="f${v3}"
            
            # establish path and sim id
            SIMID="${SQUARE}${DIPOLE}a${NUMFRAC}${FIRSTDIRECTORY}_${SECONDDIRECTORY}${THIRDDIRECTORY}"
            DIRECTORY="${SQUARE}x${SQUARE}/${FIRSTDIRECTORY}/${SECONDDIRECTORY}/${THIRDDIRECTORY}"
            SUBDAG="${SIMID}.spl"
                
            # generate simulation files in subdirectory
            ./simbin/hpc/chtc/gensimulation.sh ${JOB} ${SIMID} ${DIRECTORY} ${ECHOPROGRAM} ${NUMFRAC} ${v1} ${v3} ${v2}
            
            # travel to subdirectory, generate job, return 
            MAIN=$PWD
            cd $DIRECTORY
            echo "condor_submit_dag -batch-name ${JOB}${SIMID} ${SIMID}.dag > ${MAIN}/${SIMID}_dagsub.out"
            cd $MAIN
            
            # add subdag to dag
            echo "SPLICE ${SIMID} ${SUBDAG} DIR ${DIRECTORY}" >> $DAG
            
        done
    done
    
    # submit DAG file
    condor_submit_dag -batch-name ${JOB}${FIRSTDIRECTORY} ${DAG} > ${JOB}${FIRSTDIRECTORY}_dagsub.out
    
done

sleep 10
condor_watch_q