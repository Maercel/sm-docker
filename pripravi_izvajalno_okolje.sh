#!/bin/bash


echo "Automatic setup."

echo "Enter repository link: "
read repolink

echo "Getting repository..."
git clone "$repolink"

if [ $? -eq 0 ]; then # if last command exit code = $? -eq = equals 0 success
    filename=$(basename "$url" .git)
    
    cd "$filename" || exit 1 # run second command if first one fails

    PYFILE="run.py"
    SHELLFILE="run.sh"
    if [ -f "$PYFILE" ]; then
        echo "Python application detected"
        python3 run.py

    elif [ -f "$SHELLFILE" ]; then
        echo "Bash application detected"
        bash run.sh

    else
        echo "No entry point defined"
        exit 1
    fi
else 
    echo "Clone failed"
    exit 1
fi