#!/bin/bash
set -e

# Matthew Dorsey
# 2022-11-21
# simbin
# generates vtk files of objects using java program

## ARGUMENTS
# none

## PARAMETERS 
# path to obj files
DIR="./xyzFIG/"

## FUNCTIONS
# none

## SCRIPT

# compile program
javac -cp java ./java/Color.java
javac -cp java ./java/Obj2Vtk.java

# move to directory containing figures
cp ./java/Color.class $DIR
cp ./java/Obj2Vtk.class $DIR

