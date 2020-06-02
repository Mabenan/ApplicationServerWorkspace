git add .
git commit -m %1
git push
cd reps
for /d %%d in (*.*) do (
    cd "%%d"
    git add .
    git commit -m %1
    git push
    cd ..
)
pause