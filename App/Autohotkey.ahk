#Include <Paths>
#Include <Win>

Class Autohotkey {

   static path := A_ProgramFiles "\AutoHotkey"

   Class v2 extends Autohotkey {

      static currVersionPath := super.path "\v2.0-beta.15"

      Class Docs extends Autohotkey {

         static exeTitle := "ahk_exe hh.exe"
         static winTitle := "AutoHotkey v2 Help " this.exeTitle
         static path := super.currVersionPath "\AutoHotkey.chm"
         
         static winObj := Win({
            winTitle: this.winTitle,
            exePath: this.path
         })

      }
   }

}