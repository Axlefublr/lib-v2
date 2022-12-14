#Include <Utils\Win>
#Include <Abstractions\Global>
#Include <Loaders\App>
#Include <Paths>
#Include <Extensions\String>
#Include <Utils\Eval>

CloseButActually() {
   Switch {
      Case WinActive(Spotify.exeTitle): Spotify.Close()
      Case WinActive(Steam.exeTitle):   Steam.Close()
      Case WinActive(Gimp.exeTitle):    Gimp.Close()
      Case WinActive(Davinci.winTitle): Davinci.Close()
      Case WinActive(Telegram.winTitle):Telegram.Close()
      Case WinActive(FL.exeTitle):      FL.Close()
      Default:                          Win.Close()
   }
}

MainApps() {
   VsCode.winObj.RunAct()
   Terminal.winObj.RunAct()
   Browser.winObj.RunAct()
   Spotify.winObj.RunAct()
   Discord.winObj.RunAct()
}

SomeLockHint(whatLock) {

   newState := !GetKeyState(whatLock, "T")

   newState_Word := newState ? "On" : "Off"
   whatLock := StrTitle(whatLock)

   Set%whatLock%State(newState)

   ToggleInfo(whatLock " " newState_Word)
}

ToggleModifier(modifierName) {

   static ctrlState  := false
   static shiftState := false
   static altState   := false
   static winState   := false

   _Toggle(key) {
      %key%State := !%key%State
      Send("{" key (%key%State ? "Down" : "Up") "}")
      ToggleObj := ToggleInfo(key " " (%key%State ? "On" : "Off"))
      return ToggleObj
   }

   _Toggle(modifierName)
}

EatingLogger() {
   AppendFile(Paths.Ptf["EatingLog"], GetDateTime() "`n")
}

Calculator(expression) {
   result := eval(expression)
   if Round(result) = result {
      result := Round(result)
   }
   return result
}

Simpsons() {
   SoundBeep 500, 600
   SoundBeep 620, 400
   SoundBeep 700, 400
   SoundBeep 850, 200
   SoundBeep 750, 600
   SoundBeep 620, 400
   SoundBeep 500, 400
   SoundBeep 420, 200
   SoundBeep 350, 200
   SoundBeep 350, 200
   SoundBeep 350, 200
   SoundBeep 370, 600
}

RemindDate() {
   static events    := JSON.parse(ReadFile(Paths.Ptf["Events"]))
   static birthdays := JSON.parse(ReadFile(Paths.Ptf["Birthdays"]))
   
   today := FormatTime(, "yy.MM.dd")
   try Info(events[today])
   
   today := FormatTime(, "MM.dd")
   try Info(birthdays[today])
}

CountLibraries() {
   libraries := 0
   loop files Paths.Lib "\*.ahk", "R" {
      libraries++
   }
   return libraries
}