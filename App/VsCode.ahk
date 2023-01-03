#Include <Win>
#Include <Text>
#Include <Tools\Info>
#Include <String>
#Include <Paths>

Class VsCode {

   static exeTitle := "ahk_exe Code.exe"
   static winTitle := "Visual Studio Code " this.exeTitle
   static path := Paths.LocalAppData "\Programs\Microsoft VS Code\Code.exe"
   static exception := "VsCodeIntegratedTerminal"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath:  this.path,
   })

   static IndentRight()   => Send("^!{Right}")
   static IndentLeft()    => Send("^!{Left}")
   static Comment()       => Send("#{End}")
   static Debug()         => Send("+!9")
   static CloseAllTabs()  => Send("+!w")
   static DeleteLine()    => Send("+{Delete}")
   static Reload()        => Send("+!y+!y")
   static CloseTab()      => Send("!w")
   static CursorBack()    => Send("!{PgUp}")
   static CursorForward() => Send("!{PgDn}")
   static Undo()          => Send("#^{sc33}")
   static Redo()          => Send("#^{sc34}")

   static WorkSpace(wkspName) {
      this.CloseAllTabs()
      this.winObj.Close()
      Run(Paths.Ptf[wkspName], , "Max")
   }

}
