Notes_Terminal := [

    "claim ownership of a directory powershell", "
    (
        $user = "LAPTOP-FSDVNK6M\axlefublr"
        Get-ChildItem "C:/Programming" -Recurse -Directory | ForEach-Object {
            icacls $_.FullName /setowner $user /T
            icacls $_.FullName /grant "${user}:(OI)(CI)F" /T
        }
    )",

    "cmd close a process",
    "taskkill /f /im name.exe",

    "ffmpeg cut out part of video", "
    (
        file 'output_part1.mp4'
        file 'output_part2.mp4'
        ffmpeg -i input.mp4 -to 00:07:00 -c copy output_part1.mp4
        ffmpeg -i input.mp4 -ss 00:08:00 -c copy output_part2.mp4
        ffmpeg -f concat -safe 0 -i inputs.txt -c copy final_output.mp4
    )",

    "passing arguments to bash functions and scripts", "
    (
        $? — contains the last command's error code
        $0 — function's name or script's name + location
        $# — holds count of positional arguments passed to the function
        $@ and $* — holds the positional arguments list
        "$@" — expands the list to separate strings
        "$*" — expands the list into a single string, separating arguments with a space
    )",

    "check how big a file is",
    "du -h file.txt",

    "tear up the contents of a file without deleting it",
    "shred",

    "watch as the file is filled in real time",
    "tail -f file.txt",

    "find command", "
    (
        `-exec command {} \;` to execute a command for each file / directory that gets returned
        `-delete` to delete the results
        `-not -path GLOB` exclude GLOB from showing up in the results
    )",

    "piping", "
    (
        `<` redirect the file's contents as the input to a command
        `>` redirect the output of a command into a file
    )",

    "ranges", "
    (
        `[]` a class of characters, accepts a range as well
        ``filename{1..10}` will catch filename1, filename2, filename3, etc up to 10 (including)
    )",

]