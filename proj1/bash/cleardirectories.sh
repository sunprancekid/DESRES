#!/bin/bash
set -e

# Matthew Dorsey
# 2022-09-26
# PolSqu
# Clears all directories in the hirearchy

DIRECTORIES=(2x2/*/*/*)
# printf '%s\n' "${DIRECTORIES[@]}"

for DIRECT in ${DIRECTORIES[@]}
do
    
    if test -d $DIRECT; then
        if [ -n "$(ls -A ${DIRECT})" ]; then
            rm ./$DIRECT/*
        fi 
    fi
done