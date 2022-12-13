#Include <Win>
#Include <Text>
#Include <Tools\Info>
#Include <String>
#Include <Paths>

Class VsCode {
   
   static exeTitle := "ahk_exe Code.exe"
   static winTitle := "Visual Studio Code " this.exeTitle
   static path := Paths.LocalAppData "\Programs\Microsoft VS Code\Code.exe"
   static exception := "Terminal"

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
   static Reload()        => Send("+!y")
   static CloseTab()      => Send("!w")
   static CursorBack()    => Send("!{PgUp}")
   static CursorForward() => Send("!{PgDn}")

   static WorkSpace(wkspName) {
      this.CloseAllTabs()
      this.winObj.Close()
      Run(Paths.Ptf[wkspName], , "Max")
   }

   static CleanText(input) {
      clean := StrReplace(input, "`r`n", "`n") ;making it easy for regex to work its magic by removing returns
      clean := clean.RegexReplace("[ \t]{2,}", " ")
      clean := clean.RegexReplace("^[!*].*\n(\n)?")
      clean := clean.RegexReplace("(\n)?\n\* .*", "`n`n")
      clean := clean.RegexReplace("(\n)?\n!\[.*", "`n`n")
      ; clean := clean.RegexReplace("\n{3,}")	;removing spammed newlines
      clean := clean.RegexReplace("(?<!\.)\n{2}(?=[^A-Z])", " ") ;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it's ignored
      clean := clean.RegexReplace("[ \t]{2,}", " ")

      WriteFile(Paths.Ptf["Clean"], clean)
      Info("Text cleaned")
   }

   static VideoUp() {
      files := [
         Paths.Ptf["Clean"],
         Paths.Ptf["Description"],
      ]
      for key, value in files {
         WriteFile(value)
      }
      FileDelete(Paths.Materials "\*.*")
   }
}
