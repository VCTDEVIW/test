@ECHO OFF
REM chcp 950
chcp 65001
call git_global.bat
echo.
echo Global variable file git_global.bat has been loaded.
echo.
echo ( ( ( Current repository identification used for remote commit ) ) )
echo gitUser: %gitUser%
echo gitEmail: %gitEmail%
echo gitRepoUrl: %gitRepoUrl%
echo.

:promptAction
echo.
echo Choose action from below:
echo ----------------------------------------------------
echo 0: Resume generic Windows CMD runtime within git-cmd
echo 00: Inspect project status (git status)
echo 01: Inspect project meta information with options (-- EXCLUSIVE OPERATION REALM --)
echo 1: Generic update branch (consolidate to origin/main, overwrite remote repository)
echo 2: Commit
echo 3: File snapshot manager (git stash) ---- Quick save
echo 4: File snapshot manager (git stash) ---- Persistent (apply)
echo 5: File snapshot manager (git stash) ---- View memory stack
echo 6: File snapshot manager (git stash) ---- Enter management
echo.
echo Pick a choice with [NUM]
set /p PA=" > "
if %PA% == 0 (
    echo.
    echo Command return #:
    echo Quitting current CMD Window...
    set PA=
    cmd /c "git-cmd.exe"
) else if %PA% == 00 (
    echo.
    echo Command return #:
    echo Running action: "git status"
    git.exe status
    echo.
    echo Listing all available branch-es:
    echo Running action: "git branch"
    git.exe branch
    echo.
    pause
    set PA=
    goto promptAction
) else if %PA% == 01 (
    set PA=
    goto enterInspectMode
) else if %PA% == 1 (
    echo.
    echo Command return #:
    echo Running action: "git checkout main"
    git.exe checkout main
    echo.
    echo Running action: "git pull"
    git.exe pull
    echo.
    echo Running action: "git submodule update --init --recursive"
    git.exe submodule update --init --recursive
    echo.
    echo Running action: "git add ."
    git.exe add .
    goto case1_inputCommitInfo
    :resumeCase1Tree
    echo Running action: "git commit -m "%comm%" -m "%tag%""
    git.exe commit -m "%comm%" -m "%tag%"
    echo.
    echo Reminder: "Actual Git tag feature is NOT applied on this yet, please ignore it!"
    echo.
    echo Running action: "git push -u origin main --tags"
    REM git.exe push -u origin main
    git.exe push -u origin main --tags
    echo.
    pause
    set comm=
    set tag=
    set PA=
    goto promptAction
) else if %PA% == 3 (
    echo.
    echo Command return #:
    echo Running action: "git stash"
    git.exe stash
    echo.
    echo Reminder: "Git stash | Quick save completed."
    echo.
    set PA=
    goto promptAction
) else if %PA% == 4 (
    echo.
    echo Command return #:
    echo Running action: "git stash apply"
    git.exe stash apply
    echo.
    echo Reminder: "Git stash | Persistence applied."
    echo.
    set PA=
    goto promptAction
) else if %PA% == 5 (
    echo.
    echo Command return #:
    echo Running action: "git stash list"
    git.exe stash list
    echo.
    set PA=
    goto promptAction
) else (
    set PA=
    goto bypassPA
)
goto promptAction

:bypassPA
echo.
echo Exception: "Unsupported prompt command intercepted!"
echo Resumed to the prompt...
echo.
goto promptAction

:enterInspectMode
echo.
echo ((( Entering // Git repository meta information inspection mode )))
echo.
echo Choose action from below:
echo ----------------------------------------------------
echo 0: Exit to main menu
echo 1: Retrieve all branches (restricted within 1-storey ONLY)
echo 2: Retrieve all logs
echo.
echo Pick a choice with [NUM]
set /p EIM=" > "
if %EIM% == 0 (
    echo.
    set EIM=
    goto promptAction
) else if %EIM% == 1 (
    echo.
    echo Command return #:
    echo Show all branches in relation to current project:
    echo Running action: "git branch"
    git.exe branch
    echo.
    echo Retrieve branches store in remote repository:
    echo Running action: "git branch -r"
    git.exe branch -r
    echo.
    echo Retrieve branches store in both local and remote repositories:
    echo Running action: "git branch -a"
    git.exe branch -a
    echo.
    pause
    set EIM=
    goto enterInspectMode
) else if %EIM% == 2 (
    echo.
    set EIM=
    goto enterLogOperation
) else (
    echo.
    echo Exception: "Unsupported prompt command intercepted!"
    echo Resumed to the prompt...
    set EIM=
    goto enterInspectMode
)
echo.
goto promptAction

:enterLogOperation
echo ((( Entering // Git Log Operation )))
echo.
echo Command return #:
echo Running action: "git log --oneline --graph --decorate"
git.exe log --oneline --graph --decorate
echo.
pause
goto enterInspectMode

:case1_inputCommitInfo
echo Leave it blank or make a comment for the change commitment?
set /p comm=" > "
if "%comm%" == "" (
    echo Warning: "No comment has been input, default placeholder is taken."
    set comm=No comment for this update commit.
)
echo.
echo Leave it blank or give a tag to this commit?
set /p tag=" > "
if "%tag%" == "" (
    echo Warning: "No tag specified, GA release will be used."
    set tag=GA release
)
goto resumeCase1Tree