#!/bin/bash


echo "Automatic setup."

if [ -z "$1" ]; then # z = is string empty
    echo "Usage: $0 <gir_url>"
    exit 1
fi 

repolink="$1"

echo "Getting repository..."
git clone "$repolink"

if [ $? -eq 0 ]; then # if last command exit code = $? -eq = equals 0 success
    filename=$(basename "$repolink" .git)
    
    cd "$filename" || exit 1 # run second command if first one fails

    PYFILE="run.py"
    SHELLFILE="run.sh"
    if [ -f "$PYFILE" ]; then
        echo "Python application detected"
        
        # container
        cp templates/python/Dockerfile Dockerfile


    elif [ -f "$SHELLFILE" ]; then
        echo "Bash application detected"
        
        # container
        cp templates/bash/Dockerfile Dockerfile

    else
        echo "No entry point defined"
        cp templates/default/Dockerfile Dockerfile
    fi

    imagename="$filename"
    docker build -t "$imagename" .
    docker run -d --name "${imagename}_container" "$imagename"


else 
    echo "Clone failed"
    exit 1
fi