#Include <Win>
#Include <Gui>

KeyCodeGetter() {

   static values_hwnd := false
   static used := false

   if values_hwnd {
      Win({winTitle: values_hwnd}).MinMax()
      return
   }

   g_values := Gui(, "Key code getter").DarkMode().MakeFontNicer(30)

   values_hwnd := g_values.hwnd

   g_values_input := g_values.Add("Edit", "background171717")

   g_values_name := g_values.Add("Text", "w400", "Key name")
   g_values_SC   := g_values.Add("Text",, "SC code")
   g_values_VK   := g_values.Add("Text", "x+100", "VK code")

   Destruction(*) {
      HotIfWinActive("ahk_id " values_hwnd)
      Hotkey("Escape", "Off")
      Hotkey("Enter", "Off")
      values_hwnd := false
      g_values.Minimize()
      g_values.Destroy()

      if !used
         return

      Hotkey("F1", "Off")
      Hotkey("F2", "Off")
      Hotkey("F3", "Off")
      used := false
   }

   toClip := (what, *) => A_Clipboard := what

   Submit(*) {
      used := true

      input := g_values_input.value
      g_values_input.value := ""

      key_name := GetKeyName(input)
      key_SC   := GetKeySC(input)
      key_VK   := GetKeyVK(input)

      key_SC := Format("sc{:X}", key_SC) ;getkey sc/vk returns a base 10 value, when both of those are actually base 16. This makes absolutely no fucking sense. So, we use format to format a base 10 integer into a base 16 int for both of them
      key_VK := Format("vk{:X}", key_VK)

      g_values_name.Text := key_name
      g_values_SC.Text   := key_SC
      g_values_VK.Text   := key_VK

      HotIfWinActive("ahk_id " values_hwnd) ;If a hotkey to call this function is under a #HotIf, the hotkeys created in this functions will be affected by that. So, we have to specify that they should have no condition.
      Hotkey("F1", toClip.Bind(g_values_name.text), "On")
      Hotkey("F2", toClip.Bind(g_values_SC.text  ), "On")
      Hotkey("F3", toClip.Bind(g_values_VK.text  ), "On")

      g_values_name.OnEvent("Click", toClip.Bind(g_values_name.text))
      g_values_SC.OnEvent("Click",   toClip.Bind(g_values_SC.text))
      g_values_VK.OnEvent("Click",   toClip.Bind(g_values_VK.text))
   }

   HotIfWinActive("ahk_id " values_hwnd)
      Hotkey("Enter" , Submit     , "On")
      Hotkey("Escape", Destruction, "On")
   g_values.OnEvent("Close", Destruction)

   g_values.Show("AutoSize y0 x" A_ScreenWidth / 20 * 12.95)

}
