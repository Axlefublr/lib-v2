#Include <Win>
#Include <Gui>

;Another alternative to outputdebug
Info(text, disappear := true) {
   g_Info := Gui("AlwaysOnTop -caption").DarkMode()
   g_Info.Add("Text", , text)

   static infos := []
   static index := 0
   index++
   Info_hwnd := g_Info.Hwnd
   infos.Push(Info_hwnd)

   fullDivisions := index // 18
   if fullDivisions
      index := index - 18 * fullDivisions + 1
   yCoord := index * 60 - 60

   Destruction(*) {
      if disappear
         SetTimer(Destruction, 0)

      if infos.Length <= 1 {
         if !disappear {
            HotIfWinExist("ahk_id " Info_hwnd)
            Hotkey("Escape", "Off")
            Hotkey("+Escape", "Off")
         }
         index := 0
      }

      if infos.Length >= 1 {
         lastGui := infos.RemoveAt(1)
         win_Close(lastGui)
      }
   }

   FullDestruction(*) {
      Loop infos.Length {
         Destruction()
      }
   }

   g_Info.OnEvent("Close", (*) => g_Info.Destroy())

   if !disappear {
      HotIfWinExist("ahk_id " Info_hwnd)
      Hotkey("Escape", Destruction, "On")
      Hotkey("+Escape", FullDestruction, "On")
   }

   if disappear
      SetTimer(Destruction, -2000)

   g_Info.Show("AutoSize NA x0 y" yCoord)

   return Info_hwnd
}

Infos(text) => Info(text, false)

ToggleInfo(text) {
   g_ToggleInfo := Gui("AlwaysOnTop -caption").DarkMode()
   g_ToggleInfo.Add("Text",, text)
   g_ToggleInfo.Show("W225 NA x1595 y640")
   return g_ToggleInfo
}