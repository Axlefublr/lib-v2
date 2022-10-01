#Include <Win>
#Include <Gui>

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

Infos(text) {
   static fontSize := 100 ; := 15
   /**
    * Assign a font size you'd like more. 20 by default
    * fontSize is not a parameter, because this would break the positioning of the guis...
    * ...and decrease performance
    * So, pick what you'd rather have: more infos at a time or better visibility
    * Tested with font sizes: 5, 10, 15, 20, 25, 50, 100 - so you can feel free to pick any font size...
    * ...and it should work
    */
   g_Info := Gui("AlwaysOnTop -caption").DarkMode(fontSize?)
   g_Info_text := g_Info.AddText(, text)
   static guiWidth := g_Info.MarginY * 5
   static maximumInfos := Floor(A_ScreenHeight / guiWidth)

   static AvailablePlaces := Map()
   static ranOnce := false
   if !ranOnce { ;I wish we could just `static loop`
      index := 0
      loop maximumInfos {
         index++
         AvailablePlaces.Set(index * guiWidth - guiWidth, false)
         /**
          * The keys of the map are the y coordinates where an info could be
          * The values start out being false, become true later when you call an info
          * This is useful, because you when you close an info by clicking on it,
          * That spot becomes available
          */
      }
      ranOnce := true
   }

   gui_hwnd := g_Info.Hwnd

   for key, value in AvailablePlaces {
      if value
         continue
      currYCoord := key
      AvailablePlaces[key] := true
      break
   }

   if !IsSet(currYCoord)
      return

   Destruction(gui_hwnd_passed, currYCoord_passed, *) {
      HotIfWinExist("ahk_id " gui_hwnd_passed)
      Hotkey("Escape", "Off")
      win_Close(gui_hwnd_passed)
      AvailablePlaces[currYCoord_passed] := false
   }
   HotIfWinExist("ahk_id " gui_hwnd)
   Hotkey("Escape", Destruction.Bind(gui_hwnd, currYCoord), "On")
   g_Info_text.OnEvent("Click", Destruction.Bind(gui_hwnd, currYCoord))
   g_Info.Show("AutoSize NA x0 y" currYCoord)
}

ToggleInfo(text) {
   g_ToggleInfo := Gui("AlwaysOnTop -caption").DarkMode()
   g_ToggleInfo.Add("Text",, text)
   g_ToggleInfo.Show("W225 NA x1595 y640")
   SetTimer(() => g_ToggleInfo.Destroy(), -1000)
   return g_ToggleInfo
}