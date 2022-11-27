#!/bin/bash
set -e

# Matthew Dorsey
# 09-22u-2022
# polsqu
# Script that generates directory hierarchy for job submissions to Henry2 HPC systems
# The directory hierarchy is organized by square model, then type of dipole, 
# then number fraction of A squares, then by system density.
# Each density sub directory contains the molecular simulation files that are submitted
# to Henry2 and the results of the molecular simulation as they are generated.

## ARGUMENTS
# none

## PARAMETERS 
# array containing the model
SQUARE=( "2" )
# array containing the type of dipoles
DIPOLE=( "A" "E")
## array containing the number fraction of A-chirality squares
XA=( "05" "10" )
## array containing the densities to explore 
ETA=( "05" "10" "15" "20" "25" "30" "35" "40" "45" "50" "55" "60" "65" "70" )

## FUNCTIONS
# generates directories
generate() 
{   
    
    ## ARGUMENTS
    # none
    
    ## PARAMETERS 
    # none
    
    ## SCRIPT
    
    for V1 in ${SQUARE[@]}
    do
        # establish the first directory
        FIRSTDIRECTORY="${V1}x${V1}"

        for V2 in ${DIPOLE[@]}
        do
            # establish the second directory
            if [[ "${V2}" == "${DIPOLE[0]}" ]]; then
                SECONDDIRECTORY="stan"
                ECHOPROGRAM="./simbin/dmd/echoprogram_2x2stan.sh"
            elif [[ "${V2}" == "${DIPOLE[1]}" ]]; then
                SECONDDIRECTORY="stre"
                ECHOPROGRAM="./simbin/dmd/echoprogram_2x2stre.sh"
            fi

            for V3 in ${XA[@]}
            do
                # establish the third directory
                THIRDDIRECTORY="a${V3}0"
            
                for V4 in ${ETA[@]}
                do
                    # establish the fourth directory, the path, and the simulation id
                    FOURTHDIRECTORY="e${V4}"
                    DIRECTORY="${FIRSTDIRECTORY}/${SECONDDIRECTORY}/${THIRDDIRECTORY}/${FOURTHDIRECTORY}"
                    SIMID="${V1}${V2}a${V3}e${V4}"
                    F90PROGRAM="${DIRECTORY}/${SIMID}.f90"
                    
                    # generate the directory
                    # if the subdirectory already exists, create it
                    if test -d $DIRECTORY; then
                        if [ -n "$(ls -A ${DIRECTORY})" ]; then
                            rm $DIRECTORY/*
                        fi 
                    else
                        mkdir -p $DIRECTORY
                    fi
                
                    # generate bsub file
                    ./simbin/hpc/bsub/genbsub.sh $DIRECTORY $SIMID
                
                    # generate fortran file and write to directory
                    $ECHOPROGRAM $SIMID $V4 $V3 >> $F90PROGRAM
                    
                done
            done
        done
    done
    
}

# updates compile-time program stored in directories
update()
{   
    
    ## ARGUMENTS
    # none
    
    ## PARAMETERS 
    # none
    
    ## SCRIPT
    
    for V1 in ${SQUARE[@]}
    do
        # establish the first directory
        FIRSTDIRECTORY="${V1}x${V1}"

        for V2 in ${DIPOLE[@]}
        do
            # establish the second directory
            if [[ "${V2}" == "${DIPOLE[0]}" ]]; then
                SECONDDIRECTORY="stan"
                ECHOPROGRAM="./simbin/dmd/echoprogram_2x2stan.sh"
            elif [[ "${V2}" == "${DIPOLE[1]}" ]]; then
                SECONDDIRECTORY="stre"
                ECHOPROGRAM="./simbin/dmd/echoprogram_2x2stre.sh"
            fi

            for V3 in ${XA[@]}
            do
                # establish the third directory
                THIRDDIRECTORY="a${V3}0"
            
                for V4 in ${ETA[@]}
                do
                    # establish the fourth directory, the path, and the simulation id
                    FOURTHDIRECTORY="e${V4}"
                    DIRECTORY="${FIRSTDIRECTORY}/${SECONDDIRECTORY}/${THIRDDIRECTORY}/${FOURTHDIRECTORY}"
                    SIMID="${V1}${V2}a${V3}e${V4}"
                    F90PROGRAM="${DIRECTORY}/${SIMID}.f90"

                    if test -f $F90PROGRAM; then
                        rm $F90PROGRAM
                    fi
                    # generate fortran file and write to directory
                    $ECHOPROGRAM $SIMID $V4 $V3 >> $F90PROGRAM
                    
                done
            done
        done
    done
    
}

## SCRIPT
                
# get options, perform operations
while getopts ":gu" option; do
    case $option in
        g) # generate directories
            generate
            exit;;
        u) # update directories
            update
            exit;;
        \?) # invalid option, inform user
            echo "gensimulation: invalid or no flag specified."
            echo "g : generate simulation directories"
            echo "u : update simulation directories"
            exit;;
    esac
done

echo "gensimulation: must specifiy option."
