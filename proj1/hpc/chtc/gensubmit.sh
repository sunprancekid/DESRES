#!/bin/bash
set -e

# Matthew Dorsey
# 2022-09-29
# polsqu
# This program generates submit files for HTCondor systems.
# This program also generates the subdirectories that are used for filesubmission

## ARGUMENTS
# first argument: id used for the batch of annealing simulations
JOB=$1
# second argument: id used for the specific annealing simulation
SIMID=$2
# third argument: path and directory to current directory
DIRECTORY=$3
# fourth argument: integer representing the sequence of the simulation in the annealing process
declare -i INT=$4

## PARAMETERS
# name of program
PROGRAM="${SIMID}.f90"
# formatted integer for file naming
INTSTRING=$(printf '%03d' $INT)
# format used for storing filed from iteration of annealing simulation
OUTNAME="${JOB}${SIMID}_${INTSTRING}"
# file that contains submission instructions for iteration of annealing simulation
FILENAME="${DIRECTORY}/sub/${SIMID}_${INTSTRING}.sub"
# list of files and remapping instructions
SAVEPOS="${JOB}${SIMID}__fposSAVE.dat"
SAVEPOSREMAP="${SAVEPOS}=save/${OUTNAME}__fposSAVE.dat"

SAVEVEL="${JOB}${SIMID}__velSAVE.dat"
SAVEVELREMAP="${SAVEVEL}=save/${OUTNAME}__velSAVE.dat"

SAVECHAI="${JOB}${SIMID}__chaiSAVE.dat"
SAVECHAIREMAP="${SAVECHAI}=save/${OUTNAME}__chaiSAVE.dat"

SAVEANNEAL="${JOB}${SIMID}__annSAVE.dat"
SAVEANNEALREMAP="${SAVEANNEAL}=save/${OUTNAME}__annSAVE.dat"

SAVESIM="${JOB}${SIMID}__simSAVE.dat"
SAVESIMREMAP="${SAVESIM}=save/${OUTNAME}__simSAVE.dat"

# omitted from program
SPHMOV="${OUTNAME}_sphmov.xyz"
SPHMOVREMAP="${SPHMOV}=mov/${SPHMOV}"

SQUMOV="${OUTNAME}_squmov.xyz"
SQUMOVREMAP="${SQUMOV}=mov/${SQUMOV}"

TXT="${OUTNAME}.txt"
TXTREMAP="${TXT}=txt/${TXT}"

ANNEAL="${OUTNAME}_anneal.csv"
ANNEALREMAP="${ANNEAL}=anneal/${ANNEAL}"

# omitted from this program
EQUIL="${OUTNAME}_equil.csv"
EQUILREMAP="${EQUIL}=equil/${EQUIL}"

OP="${OUTNAME}_op.csv"
OPREMAP="${OP}=op/${OP}"


## FUNCTINOS
# none

## SCRIPT

# comma seperated list of files that should be transfered on input
TRANSFILEIN=$PROGRAM
if [[ ${INT} -gt 0 ]]; then 
    # if the simulation is not the first in the sequence
    # pass the previous simulation's save files
    TRANSFILEIN="${TRANSFILEIN}, save/${SAVEPOS}, save/${SAVEVEL}, save/${SAVECHAI}, save/${SAVEANNEAL}, save/${SAVESIM}"
fi

# comma seperated list of files that should be transfered on output
TRANSOUT="${SQUMOV}, ${OP}, ${TXT}, ${ANNEAL}, ${SAVEPOS}, ${SAVEVEL}, ${SAVECHAI}, ${SAVEANNEAL}, ${SAVESIM}"

# semicolon seperated list of output files and where they should be remapped to
TRANSOUTREMAP="${SQUMOVREMAP}; ${OPREMAP}; ${TXTREMAP}; ${ANNEALREMAP}; ${SAVEPOSREMAP}; ${SAVEVELREMAP}; ${SAVECHAIREMAP}; ${SAVEANNEALREMAP}; ${SAVESIMREMAP}"
# TODO ADD EQUILIBRIUM REMAP 
 
echo "generating ${FILENAME}"
echo "executable = exec/${SIMID}.sh" > $FILENAME
echo "" >> $FILENAME
echo "should_transfer_files = YES" >> $FILENAME
echo "transfer_input_files = ${TRANSFILEIN}" >> $FILENAME
echo "transfer_output_files = ${TRANSOUT}" >> $FILENAME
echo "transfer_output_remaps = \"${TRANSOUTREMAP}\"" >> $FILENAME
echo "when_to_transfer_output = ON_SUCCESS" >> $FILENAME
echo "" >> $FILENAME
echo "log = log/${SIMID}.${INTSTRING}.log" >> $FILENAME
echo "error = err/${SIMID}.${INTSTRING}.err" >> $FILENAME
echo "output = out/${SIMID}.${INTSTRING}.out" >> $FILENAME
#echo "stream_error = True" >> $FILENAME # FOR DEBUGGING
#echo "stream_output = True" >> $FILENAME # FOR DUBUGGING 
echo "" >> $FILENAME
echo "request_cpus = 1" >> $FILENAME
echo "request_disk = 100MB" >> $FILENAME
echo "request_memory = 500MB" >> $FILENAME
echo "" >> $FILENAME
echo "requirements = (HAS_GCC == true) && (HAS_AVX2 == true) && (Mips > 30000)" >> $FILENAME
echo "" >> $FILENAME
echo "queue" >> $FILENAME
