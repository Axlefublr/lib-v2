#Include <Global>
#Include <Text>
#Include <Paths>
#Include <Win>
#Include <ClipSend>

Class Telegram {
   
   static winTitle := "Telegram ahk_exe Telegram.exe"
   
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
      win_RunAct("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
      this.Channel("Diary")
      ClipSend(diary)
      Send("{Enter}")
   }
}
