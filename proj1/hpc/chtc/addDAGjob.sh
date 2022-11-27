#!/bin/bash
set -e

# Matthew Dorsey
# 2022-10-05

# this program adds one iteration of an annealing simulation to the end of the annealing simulations DAG file

## ARGUMENTS
# first argument: name of the dag file to write the job instructions to
DAG=$1
# second argument: id associated with the batch of annealing simulations
BATCH=$2
# second argument: id associated with the annealing simulation
SIMID=$3
# third argument: iteraction assocated with the job
INT=$4


## PARAMETERS 
# formatted integer string for file naming
INTSTRING=$(printf '%03d' $INT)
# formatted job id with simulation id
JOB="${SIMID}_${INTSTRING}"
# number of times to retry a job if it exits with a non-zero exit code
declare -i RETRY=5


## FUNCTIONS
# none


## SCRIPT

echo "JOB ${JOB} sub/${JOB}.sub" >> $DAG
echo "SCRIPT POST ${JOB} ./exec/gensave.sh ${BATCH} ${SIMID} ${INT}" >> $DAG
echo "RETRY ${JOB} ${RETRY}" >> $DAG

# the last line saves the iterative save files from the simulation as the next simulation files 
# that will be transfered to the execute node. should be completed after every job
