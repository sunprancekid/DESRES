#!/bin/bash
set -e

# script that downloads and updates simulation directories using rsync
# call from prelim2 directory

while getopts ":ad" option; do
    case $option in
        a) # update entire directory
            rsync -Pavz madorse2@login.hpc.ncsu.edu:/share/hall2/madorse2/prelim2/ ../
            ;;
        d) # only update sub directories that contain simulation files
            rsync -Pavz madorse2@login.hpc.ncsu.edu:/share/hall2/madorse2/prelim2/2x2 ./
            ;;
        \?)# invalid option, inform user
            echo "update: invalid or no flag specified."
            echo "a : update entire directory"
            echo "d : only update sub directories that contain simulation files"
            exit;;
    esac
done
            
javac ./simbin/java/SimUpdate.java
java -cp simbin/java SimUpdate
