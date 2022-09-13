;No dependencies

CreateSymlink(source, destination, isDir := false) => (
   isDir := isDir ? "/D" : "",
   RunSpec('mklink ' isDir ' "' destination '" "' source '"', true)
)

RunWith(with, runFile) => Run(with ' "' runFile '"')

RunSpec(commands, AsAdmin := false, seeCmd := false) {

   commands_converted := IsObject(commands) ? "" : commands
   AsAdmin := AsAdmin ? "*RunAs " : ""
   seeCmd := seeCmd ? "Max" : "hide"

   if IsObject(commands) {

      commands_concoct := " & "	;to run multiple lines using Run, you concoct them together using &
      for key, value in commands {

         if key = commands.Length	;if it's the last command
            commands_concoct := ""	;we don't need to append the commands together anymore

         commands_converted .= value commands_concoct
      }
   }

   RunWait(AsAdmin A_ComSpec " /c " commands_converted, , seeCmd)
}
