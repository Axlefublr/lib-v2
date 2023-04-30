Notes_Terminal := Map(

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
        ffmpeg -i input.mp4 -ss 00:00:00 -to 00:07:00 -c copy output_part1.mp4
        ffmpeg -i input.mp4 -ss 00:08:00 -c copy output_part2.mp4
        # text file:
        file 'output_part1.mp4'
        file 'output_part2.mp4'
        ffmpeg -f concat -safe 0 -i inputs.txt -c copy final_output.mp4
    )"

)