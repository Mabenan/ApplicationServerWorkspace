git pull
cd reps
for /d %%d in (*.*) do (
    cd "%%d"
    git pull
    cd ..
)
pause