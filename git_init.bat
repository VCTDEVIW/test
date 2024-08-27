@ECHO OFF
call git_global.bat
echo.
echo Global variable file git_global.bat has been loaded.
echo.

echo gitUser: %gitUser%
echo gitEmail: %gitEmail%
echo gitRepoUrl: %gitRepoUrl%

echo.
git.exe config --global user.name %gitUser%
git.exe config --global user.email %gitEmail%
git.exe init
echo "# BEGIN..." >> README.md
git.exe add README.md
git.exe add .
git.exe commit -m "first commit"
git.exe branch -M main
git.exe remote add origin "%gitRepoUrl%"
git.exe push -u origin main

REM cmd /c "git-cmd"