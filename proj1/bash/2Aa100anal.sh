#!/bin/tcsh
#BSUB -n 1
#BSUB -W 2880
#BSUB -o out.%J
#BSUB -e err.%J
#BSUB -q mrsec
#BSUB -J 2Aa10anal

module load java
javac ./simbin/SimAnalysis.java

set squ="2"
set dp="stan"
set frac="100"
set eta=( "05" "10" "15" "20" "25" "30" "35" "40" "45" "50" "55" "60" "65" "70" )

foreach v1 ($eta)
do
    java -cp simbin SimAnalysis ${squ} ${dp} ${frac} ${v1} 
done
