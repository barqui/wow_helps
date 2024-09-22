@echo off
setlocal enabledelayedexpansion

for %%o in (chat-cache.txt chat-cache.old) do (
    rem Set the path to the original file (start from the directory where the batch file is located)
    rem set "OriginalFile=chat.txt"

    echo %%o

    rem Search through all subdirectories starting from the "Account" directory
    for /r "Account" %%A in (*) do (
        rem Check if the current path points to a file named "chat.txt"
        
        if "%%~nxA"=="%%o" (
            rem Set the path for the target file
            set "TargetFile=%%~A"

            del "!TargetFile!"
            
            rem Check if the target file already exists
            if exist "!TargetFile!" (
                rem Backup the existing target file by renaming it
                ren "!TargetFile!" "old_%%~nxA"
                echo Existing target file has been backed up: "old_%%~nxA"
            )
            
            rem Replace the target file with MKLINK
            mklink /h "!TargetFile!" "%%o"
            
            echo Target file has been replaced with MKLINK: "!TargetFile!"
        )
    )
)

echo The operation has been completed.
endlocal
