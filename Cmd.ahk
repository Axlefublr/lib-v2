;No dependencies

/**
 * Creates a symlink of a file / folder
 * @param source {str} The path of what the symlink should be *of* (the path to the original file / folder)
 * @param destination {str} The path to where the symlink should be located at
 * @param isDir {bool} Specify as true of your source is a directory, instead of a file
 */
CreateSymlink(source, destination, isDir := false) => (
   isDir := isDir ? "/D" : "",
   RunSpec('mklink ' isDir ' "' destination '" "' source '"', true)
)

/**
 * Syntax sugar: "Run *this* using *this program*"
 * @param with {str} The program to use to run something with: either Program.exe format, or the full path to the executable
 * @param runFile {str} The path to the file (or link!) you want to run
 */
RunWith(with, runFile) => Run(with ' "' runFile '"')

/**
 * A way to execute cmd commands using ahk, rather than running a bat script
 * @param commands {str,arr} Specify a string of the command if it's just one. Specify an array of strings for multiple commands
 * @param AsAdmin {bool} Whether the commands should run with administrative priviledges
 * @param seeCmd {bool} Whether you want to see the cmd window (it will technically exist either way)
 * @param startingDir {str} What directory should the commands be run from (you could instead use cd to change directory to reach the same effect)
 */
RunSpec(commands, AsAdmin := false, seeCmd := false, startingDir?) {

   commands_converted := IsObject(commands) ? "" : commands
   AsAdmin := AsAdmin ? "*RunAs " : ""
   seeCmd := seeCmd ? "Max" : "hide"

   if IsObject(commands) {

      commands_concoct := " & " ;to run multiple lines using Run, you concoct them together using &
      for key, value in commands {

         if key = commands.Length ;if it's the last command
            commands_concoct := "" ;we don't need to append the commands together anymore

         commands_converted .= value commands_concoct
      }
   }

   RunWait(AsAdmin A_ComSpec " /c " commands_converted, startingDir ?? "", seeCmd)
}
