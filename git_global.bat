@EcHO OFF
title %~n0
title "Portable Git Workspace :: %cd%"
cls

REM git config --global user.name "Your Name"
REM git config --global user.email "your_email@example.com"
REM ----
set gitUser=Issac Wan
set gitEmail=issac.wan@vastcomtech.com
set gitRepoUrl=https://github.com/VCTDEVIW/test.git

REM "%basePath% is the parent folder of .\PortableGit"
REM "%projectHome% is the absolute path of the Project root directory"
REM ----
set basePath=D:\VM Direct Sharing\rhel_8.8_projects\git
set gitRoot=%basePath%\PortableGit
set gitBin=%gitRoot%\bin
set projectHome=D:\VM Direct Sharing\rhel_8.8_projects\git\new
cd /d "%projectHome%"

set Path=
set Path=%Path%;%SystemRoot%\system32
set Path=%Path%;%SystemRoot%\system
set Path=%Path%;%gitRoot%
set Path=%Path%;%gitBin%
set Path=%Path%;%gitBin%\bin.exe
set Path=%Path%;%gitRoot%\mingw64\libexec\git-core
set Path=%Path%;%gitRoot%\mingw64\bin
set Path=%Path%;%gitRoot%\llvm-mingw\bin
echo Init datetime: %date% %time%
echo.
echo Check current Git runtime version:
git.exe version
echo.

echo Current datetime: %date% %time%
set disp=Type in command to proceed...
echo %disp%
REM cmd /c "git-cmd"