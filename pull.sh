#!/bin/sh
git pull
cd reps
for d in */ ; do 
    cd "$d"
    git pull
    cd ..
done
pause
