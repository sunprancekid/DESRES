#!/bin/bash
set -e

# Matthew Dorsey
# 2022-09-29
# polsqu
# Script that organizes and submites directory level annealing simulations to HTCondor.

## ARGUMENTS
# first argument: name of the job associated with the batch of annealing simulations
JOB=$1
# second argument: id used for annealing simulation
SIMID=$2 
# third argument: pathway to directory from current directory
DIRECTORY=$3
# fourth argument: script that echos the compile-time program
ECHOPROGRAM=$4
# fifth argument: number fraction of A chirality squares
NUMFRAC=$(printf '%3.2f'  $(awk "BEGIN { print $5/10 }"))
# sixth argument: area fraction of simulation
ETA=$(printf '%3.2f' $(awk "BEGIN { print $6/100 }"))
# seventh argument: fraction by which to reduce the annealing simulation
FRAC=$(printf '%3.2f' $(awk "BEGIN { print $7/100 }"))
# eighth argument: number of events in the annealing simulation
EVENTS="${8}0000000"

## PARAMETERS
# initial temperature that the annealing simulation starts at
MAXTEMP="1.5"
# final temperature at the annealing simulation stops at
MINTEMP="0.1"
# number of times to iterate annealing simulations
declare -i NUMITERATIONS=20
# number of times to retry a job if it exits with a non-zero exit code
declare -i RETRY=5
# compile-time program
PROGRAM="${DIRECTORY}/${SIMID}.f90"
if [ -f $PROGRAM ]; then
    # remove the program if it exists
    rm $PROGRAM
fi
# dag file that contains annealing simulation flow
DAG="${DIRECTORY}/${SIMID}.spl"
if [ -f $DAG ]; then
    # remove the dag file if it exists
    rm $DAG
fi

## FUNCTIONS
# function that checks to see if a directory exists, or if it contains any files
gendir ()
{
    ## ARGUMENTS
    # first argument: directory with path to check for
    local directory=$1
    
    ## PARAMETERS
    # none
    
    ## SCRIPT
    # check to see if the directory exists
    if test -d $directory; then 
        # if the directory exists, check to see if it contains any files
        if [ -n "$(ls -A $directory)" ]; then 
            rm -r "${directory}/*"
        fi
    else
        # make the directory
        mkdir -p $directory
    fi
    
}

# function that generates the number of times an annealing simulation should
# be iterated based the fraction of temperature reduction
genit ()
{
    ## ARGUMENTS
    # first argument: fraction to reduce the temperature of the annealing simulation
    # by each iteration
    F=$1
    
    ## PARAMETERS
    # none
    
    ## TODO
    # write java program that predicts the number of iterations in an annealing simulation
    # based on the starting / ending temp, and the temp reduction fraction
    
    ## SCRIPT
    if [[ $F == "0.90" ]]; then 
        NUMITERATIONS=25
    elif [[ $F == "0.91" ]]; then
        NUMITERATIONS=28
    elif [[ $F == "0.92" ]]; then
        NUMITERATIONS=32
    elif [[ $F == "0.93" ]]; then
        NUMITERATIONS=37
    elif [[ $F == "0.94" ]]; then
        NUMITERATIONS=43
    elif [[ $F == "0.95" ]]; then 
        NUMITERATIONS=52
    elif [[ $F == "0.96" ]]; then 
        NUMITERATIONS=66
    elif [[ $F == "0.97" ]]; then
        NUMITERATIONS=88
    elif [[ $F == "0.98" ]]; then
        NUMITERATIONS=134
    elif [[ $F == "0.99" ]]; then
        NUMITERATIONS=269
    fi
        

}

## SCRIPT

# GENERATE DIRECTORIES, FILES
# directory that contains files related to simulation id
echo ""
echo "generating ${DIRECTORY} subhierarchy"
if test -d ${DIRECTORY}; then 
    rm -r ${DIRECTORY}
fi
# directory for HTCondor submission files
gendir "${DIRECTORY}/sub"
# directory for executables associated with each HTCondor job
gendir "${DIRECTORY}/exec"
# directory for save files
gendir "${DIRECTORY}/save"
# directory for err files
gendir "${DIRECTORY}/err"
# directory for output files
gendir "${DIRECTORY}/out"
# directory for log files
gendir "${DIRECTORY}/log"
# directory for save files
gendir "${DIRECTORY}/save"
# directory for equilibrium files
gendir "${DIRECTORY}/equil"
# directpry for order parameter files
gendir "${DIRECTORY}/op"
# directory for movie files
gendir "${DIRECTORY}/mov"
# directory for anneal files
gendir "${DIRECTORY}/anneal"
# directory for txt files
gendir "${DIRECTORY}/txt"


# generate program and executables (only needs to be done once)
echo "generating ${PROGRAM}"
$ECHOPROGRAM $JOB $SIMID $ETA $NUMFRAC $EVENTS $FRAC >> $PROGRAM
./simbin/hpc/chtc/genexecute.sh $SIMID $DIRECTORY

# copy gensave.sh from simbin to local directory
cp ./simbin/hpc/chtc/gensave.sh $DIRECTORY/exec/
chmod u+x $DIRECTORY/exec/gensave.sh

# loop through each iteration
genit $FRAC
for INT in `seq 0 1 $NUMITERATIONS`
do

    # used for file formatting
    declare -i INTINT=$INT
    INTSTRING=$(printf '%03d' $INT)
    DAGJOB="${SIMID}_${INTSTRING}"
    
    # generate the submission file
    ./simbin/hpc/chtc/gensubmit.sh $JOB $SIMID $DIRECTORY $INT

    # add submission file and post job script to dag file
    echo "JOB ${DAGJOB} sub/${DAGJOB}.sub" >> $DAG
    echo "RETRY ${DAGJOB} ${RETRY}" >> $DAG
    if [[ ${INTINT} -ne 0 ]]; then
    
        # used for file formatting
        PREV=$((INT-1))
        PREVSTRING=$(printf '%03d' $PREV)
        
        # save files from previous run are used for next run
        echo "SCRIPT PRE ${DAGJOB} ./exec/gensave.sh ${JOB} ${SIMID} ${PREV}" >> $DAG
        # establish PARENT / CHILD relationships
        echo "PARENT "$SIMID"_"$PREVSTRING" CHILD "$SIMID"_"$INTSTRING >> $DAG
    fi
done

echo "generating ${DAG}"
