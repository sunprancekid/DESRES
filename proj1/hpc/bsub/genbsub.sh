#!/bin/bash
set -e

# Matthew Dorsey
# 09-22-2022
# polsqu
# script that generates a bsub file and stores it in the specified directory

## ARGUMENTS
# first argument: path to directory to store bsub file
PATH=$1

# second argument: simid that is used to title busb file
SIMID=$2 


## PARAMETERS
# file that contains bsub script
FILE="${PATH}/test.bsub"
QUEUE="serial"
WALLCLOCK="2880"

## SCRIPT

# check for flags
# THIS FEATURE DOESN'T WORK FOR SOME REASON
while getopts ":qw" FLAG; do
    case $FLAG in
        q) # specify the queue to submit to
            QUEUE=$OPTARG;;
        w) # specify the wall clock time of the job
            WALLCLOCK=$OPTARG;;
    esac
done

# if the file already exists, remove it
if test -f $FILE; then 
    rm $FILE
fi

# write submission script to the file
echo "#!/bin/tcsh" >> $FILE
echo "#BSUB -n 1" >> $FILE # specify the number of cores
echo "#BSUB -W ${WALLCLOCK}" >> $FILE # specify the wall clock time
echo "#BSUB -o out.%J" >> $FILE # specify the name of the output file
echo "#BSUB -e err.%J" >> $FILE # specify the name of the error file
echo "#BSUB -q ${QUEUE}" >> $FILE # specify the queue to submit each job to
echo "#BSUB -J ${SIMID}" >> $FILE # specify the job id
echo "" >> $FILE
echo "module load PrgEnv-intel" >> $FILE # load the fortran environment
echo "ifort -no-wrap-margin -O3 -fp-model=precise ${SIMID}.f90" >> $FILE # compile the program
echo "./a.out" >> $FILE # execute the program
