#Include <Win>

Class Autohotkey {

   static path := A_ProgramFiles "\AutoHotkey"
   static currVersion := this.path "\v2.0-beta.15"
   
   Class Docs extends Autohotkey {

      static exeTitle := "ahk_exe hh.exe"
      static winTitle := "ahk_group AhkDocs " this.exeTitle
      
      Class v2 extends Autohotkey.Docs {

         static winTitle := "AutoHotkey v2 Help " super.exeTitle
         static path := super.currVersion "\AutoHotkey.chm"
         
         static winObj := Win({
            winTitle: this.winTitle,
            exePath: this.path
         })
      }
      Class v1 extends Autohotkey.Docs {

         static winTitle := "AutoHotkey Help " super.exeTitle
      }
      
      static SetupGroup() {
         
         static ranAlready := false
         
         if ranAlready {
            return
         }

         GroupAdd("AhkDocs", this.v2.winTitle)
         GroupAdd("AhkDocs", this.v1.winTitle)
         
         ranAlready := true
      }

   }
}