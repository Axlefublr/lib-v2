#Include <Gui>

CoordGetter() {
   CoordMode("Mouse", "Screen")
   MouseGetPos(&ScrX, &ScrY)

   CoordMode("Mouse", "Window")
   MouseGetPos(&WinX, &WinY)

   CoordMode("Mouse", "Client")
   MouseGetPos(&CliX, &CliY)

   CoordMode("Pixel", "Screen")
   pixel := PixelGetColor(ScrX, ScrY, "Alt Slow")

   g_CrdGet := Gui(, "Coord Getter").DarkMode().MakeFontNicer(30)

   CrdGet_hwnd := g_CrdGet.hwnd

   toClip := (text, *) => A_Clipboard := text

   g_CrdGet.Add("Text", , "Screen: ")
      .OnEvent("Click", toClip.Bind(ScrX " " ScrY))
   g_CrdGet.Add("Text", "x+", "x" ScrX " ")
      .OnEvent("Click", toClip.Bind(ScrX))
   g_CrdGet.Add("Text", "x+", "y" ScrY " ")
      .OnEvent("Click", toClip.Bind(ScrY))
   g_CrdGet.Add("Text", "xm", "Window: ")
      .OnEvent("Click", toClip.Bind(WinX " " WinY))
   g_CrdGet.Add("Text", "x+", "x" WinX " ")
      .OnEvent("Click", toClip.Bind(WinX))
   g_CrdGet.Add("Text", "x+", "y" WinY " ")
      .OnEvent("Click", toClip.Bind(WinY))
   g_CrdGet.Add("Text", "xm", "Client: ")
      .OnEvent("Click", toClip.Bind(CliX " " CliY))
   g_CrdGet.Add("Text", "x+", "x" CliX " ")
      .OnEvent("Click", toClip.Bind(CliX))
   g_CrdGet.Add("Text", "x+", "y" CliY " ")
      .OnEvent("Click", toClip.Bind(CliY))
   g_CrdGet.Add("Text", "xm", "Pixel: " pixel)
      .OnEvent("Click", toClip.Bind(pixel))
   g_CrdGet.Add("Text", "xm", "CtrlClick Format")
      .OnEvent("Click", toClip.Bind('"x' CliX " y" CliY '"'))

   Destruction := (*) => (
      HotIfWinActive("ahk_id " CrdGet_hwnd),
      Hotkey("Escape", "Off"),
      Hotkey("1", "Off"),
      Hotkey("2", "Off"),
      Hotkey("3", "Off"),
      Hotkey("4", "Off"),
      Hotkey("5", "Off"),
      g_CrdGet.Minimize()
      g_CrdGet.Destroy()
   )

   HotIfWinActive("ahk_id " CrdGet_hwnd)
   Hotkey("Escape", Destruction, "On")
   Hotkey("1", toClip.Bind(ScrX " " ScrY), "On")
   Hotkey("2", toClip.Bind(WinX " " WinY), "On")
   Hotkey("3", toClip.Bind(CliX " " CliY), "On")
   Hotkey("4", toClip.Bind(pixel), "On")
   Hotkey("5", toClip.Bind('"x' CliX " y" CliY '"'), "On")
   g_CrdGet.OnEvent("Close", Destruction)

   g_CrdGet.Show("AutoSize y0 x" A_ScreenWidth / 20 * 13.5)
}
