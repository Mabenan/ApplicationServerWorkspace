#!/bin/sh
git add .
git commit -m "$1"
git push
cd reps
for d in */ ; do
    cd "$d"
    git add .
    git commit -m "$1"
    git push
    cd ..
done
pause
