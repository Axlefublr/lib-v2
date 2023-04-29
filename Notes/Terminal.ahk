Notes_Terminal := Map(

    "claim ownership of a directory powershell", "
    (
        $user = "LAPTOP-FSDVNK6M\axlefublr"
        Get-ChildItem "C:/Programming" -Recurse -Directory | ForEach-Object {
            icacls $_.FullName /setowner $user /T
            icacls $_.FullName /grant "${user}:(OI)(CI)F" /T
        }
    )",

)