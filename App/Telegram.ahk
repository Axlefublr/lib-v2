#Include <Global>
#Include <Text>
#Include <Paths>
#Include <Win>
#Include <ClipSend>

Class Telegram {

   static processExe := "Telegram.exe"
   static exeTitle := "ahk_exe " this.processExe
   static winTitle := "Telegram " this.exeTitle
   static path := A_AppData "\Telegram Desktop\Telegram.exe"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path
   })
   
   static Close() {
      this.winObj.Close()
      ProcessClose(this.processExe)
   }

   static Voice() => ClickThenGoBack_Event("1452 1052")

   static Scroll() => ControlClick("X1434 Y964")

   static Channel(channelToFind) => (
      ControlClick("X456 Y74"),
      Send(channelToFind),
      Send("{Enter}")
   )

   static Diary() {
      diary := ReadFile(Paths.Ptf["Diary"])
      WriteFile(Paths.Ptf["Diary"])
      this.winObj.RunAct()
      this.Channel("Diary")
      ClipSend(diary)
      Send("{Enter}")
   }
}
