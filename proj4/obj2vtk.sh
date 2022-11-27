#!/bin/bash
set -e

# Matthew Dorsey
# 2022-11-21
# simbin
# generates vtk files of objects using java program

## ARGUMENTS
# first argument: name of directory containing .obj files
OBJ=$1

## PARAMETERS 
# path to obj files
DIR="./xyzFIG/"

## FUNCTIONS
# none

## SCRIPT

# compile program
javac -cp . Color.java
javac -cp . Obj2Vtk.java

# execute program with argument
java -cp . Obj2Vtk $OBJ

