#Include <Global>
#Include <Win>
#Include <Gui>
#Include <Info>
#Include <Get>
#Include <String>
#Include <CleanInputBox>

tool_KeyCodeGetter() {

   static values_hwnd := false
   static used := false

   if values_hwnd {
      win_MinMax(values_hwnd)
      return
   }

   g_values := Gui(, "Key code getter")
   g_values.BackColor := "171717"
   g_values.SetFont("s30 cC5C5C5", "Consolas")

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

tool_RelativeCoordGetter() {
   static var := 0
   static initX
   static initY
   if !var {
      MouseGetPos(&locX, &locY)
      ToolTip("Initial position")
      initX := locX
      initY := locY
      var := !var
      return
   }
   ToolTip()
   MouseGetPos(&loc1X, &loc1Y)

   relPosX := loc1X - initX
   relPosY := loc1Y - initY

   initX := 0
   initY := 0
   var := !var

   g_relative := Gui(, "Relative coord getter")
   g_relative.BackColor := "171717"
   g_relative.SetFont("s30 cC5C5C5", "Consolas")

   g_relative_textX := g_relative.Add("Text", , "Relative X: " relPosX)
   g_relative_textY := g_relative.Add("Text", , "Relative Y: " relPosY)

   topRightCorner := A_ScreenWidth / 20 * 14.3

   g_relative_hwnd := g_relative.hwnd

   Destruction := (*) => (
      HotIfWinActive("ahk_id " g_relative_hwnd),
      Hotkey("Escape", "Off"),
      Hotkey("1", "Off"),
      Hotkey("2", "Off"),
      g_relative.Destroy()
   )

   toClip(text, *) {
      static var := 0
      var++
      A_Clipboard := text
      Info("copied " text)
      if var >= 2
         Destruction()
   }

   HotIfWinActive("ahk_id " g_relative_hwnd)
   Hotkey("1", toClip.Bind(relPosX), "On")
   Hotkey("2", toClip.Bind(relPosY), "On")
   Hotkey("Escape", Destruction, "On")

   g_relative_textX.OnEvent("Click", toClip.Bind(relPosX))
   g_relative_textY.OnEvent("Click", toClip.Bind(relPosY))

   g_relative.OnEvent("Close", Destruction)

   g_relative.Show("AutoSize y0 x" topRightCorner)

}

tool_CoordGetter() {
   CoordMode("Mouse", "Screen")
   MouseGetPos(&ScrX, &ScrY)

   CoordMode("Mouse", "Window")
   MouseGetPos(&WinX, &WinY)

   CoordMode("Mouse", "Client")
   MouseGetPos(&CliX, &CliY)

   CoordMode("Pixel", "Screen")
   pixel := PixelGetColor(ScrX, ScrY, "Alt Slow")

   g_CrdGet := Gui(, "Coord Getter")
   g_CrdGet.Backcolor := "171717"
   g_CrdGet.SetFont("S30 cC5C5C5", "Consolas")

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

tool_WindowGetter() {

   ;Getting the current window's info
   winTitle   := WinGetTitle("A")
   winTitle_regex := ConvertToRegex(winTitle) ;Dependency from https://github.com/Axlefublr/lib-v2/Get.ahk
   winExePath := WinGetProcessPath("A")
   winExe     := WinGetProcessName("A")
   winID      := WinGetID("A")
   winPID     := WinGetPID("A")

   ;Gui creation
   g_WinGet := Gui(, "WindowGetter")
   g_WinGet.Backcolor := "171717"
   g_WinGet.SetFont("S20 cC5C5C5", "Consolas")

   WinGet_hwnd := g_WinGet.hwnd

   ;Show the window's info
   g_WinGet_WinTitle         := g_WinGet.Add("Text", "Center", winTitle)
   g_WinGet_WinTitle_regex   := g_WinGet.Add("Text", "Center", winTitle_regex)
   g_WinGet_WinExePath       := g_WinGet.Add("Text", "Center", winExePath)
   g_WinGet_WinExe           := g_WinGet.Add("Text", "Center", winExe)
   g_WinGet_WinID            := g_WinGet.Add("Text", "Center", "id: " winID)
   g_WinGet_WinPID           := g_WinGet.Add("Text", "Center", "pid: " winPID)

   ;Destroys the gui as well as every previously created hotkeys
   FlushHotkeys := (*) => (
      HotIfWinActive("ahk_id " WinGet_hwnd),
      Hotkey("1", "Off"),
      Hotkey("2", "Off"),
      Hotkey("3", "Off"),
      Hotkey("4", "Off"),
      Hotkey("5", "Off"),
      Hotkey("6", "Off"),
      Hotkey("Escape", "Off"),
      g_WinGet.Destroy()
   )

   ;This function copies the text you clicked to your clipboard and destroys the gui right after
   ToClip := (text, *) => (
      A_Clipboard := text,
      FlushHotkeys()
   )

   ;Making the func objects to later call in two separate instances
   ToClip_Title       := ToClip.Bind(winTitle) ;We pass the params of winSmth
   ToClip_Title_regex := ToClip.Bind(winTitle_regex)
   ToClip_Path        := ToClip.Bind(winExePath) ;To copy it, disable the hotkeys and destroy the gui
   ToClip_Exe         := ToClip.Bind(winExe)
   ToClip_ID          := ToClip.Bind(winID)
   ToClip_PID         := ToClip.Bind(winPID)

   HotIfWinActive("ahk_id " WinGet_hwnd)
   Hotkey("1", ToClip_Title, "On")
   Hotkey("2", ToClip_Title_regex, "On")
   Hotkey("3", ToClip_Path, "On")
   Hotkey("4", ToClip_Exe, "On")
   Hotkey("5", ToClip_ID, "On")
   Hotkey("6", ToClip_PID, "On")

   Hotkey("Escape", FlushHotkeys, "On")

   g_WinGet_WinTitle.OnEvent("Click",         ToClip_Title)
   g_WinGet_WinTitle_regex.OnEvent("Click",   ToClip_Title_regex)
   g_WinGet_WinExePath.OnEvent("Click",       ToClip_Path)
   g_WinGet_WinExe.OnEvent("Click",           ToClip_Exe)
   g_WinGet_WinID.OnEvent("Click",            ToClip_ID)
   g_WinGet_WinPID.OnEvent("Click",           ToClip_PID)

   g_WinGet.OnEvent("Close", FlushHotkeys) ;Destroys the gui when you close the X button on it

   g_WinGet.Show("AutoSize y0")
}

tool_Timer(minutes, shouldExit := false) {
   endTime := Round(A_TickCount + minutes * 60000)

   _isItTime() {
      if A_TickCount < endTime
         return

      SetTimer(_isItTime, 0)

      timeUp := Gui("AlwaysOnTop")
      timeUp.BackColor := "171717"
      timeUp.SetFont("s20 cC5C5C5", "Consolas")
      timeUp.Add("Text", , "Time's up!`n" minutes " minutes have passed")

      guiHwnd := timeUp.hwnd

      timeUp.Show("AutoSize")

      timeUp.OnEvent("Close", (*) => timeUp.Destroy())
      HotIfWinActive("ahk_id " guiHwnd)
      Hotkey("Escape", (*) => timeUp.Destroy(), "On")

      _Timer() {
         SoundBeep(800, 200)
         if WinExist(guiHwnd)
            return
         Settimer(_Timer, 0)
         HotIfWinActive("ahk_id " guiHwnd)
         Hotkey("Escape", "Off")
         if shouldExit
            ExitApp()
      }

      Settimer(_Timer, 1000)
   }

   SetTimer(_isItTime, 500)
   Info("Timer set for " minutes " minutes!")
}

;Select a file to run on startup
tool_StartupRun() {
   selectedFile := FileSelect("S", A_WorkingDir)
   SplitPath(selectedFile, &fileName)
   FileCreateShortcut(selectedFile, A_StartMenu "\Programs\Startup\" fileName ".lnk")
}

Snake(SquareSide, delay, timeout) {

   static isSlithering := false

   if isSlithering {
      Info("Press escape to disable snake first")
      return
   }

   maxSide := Min(A_ScreenWidth, A_ScreenHeight)
   if SquareSide > maxSide
      SquareSide := maxSide
   else if SquareSide <= 1
      SquareSide := 2

   timeout := timeout * 1000

   static colors := [
      "D12229",	;red
      "F68A1E",	;Orange
      "FDE01A",	;Yellow
      "007940",	;Green
      "24408E",	;Blue
      "732982"    ;Purple
   ]

   static Columns := A_ScreenWidth // SquareSide
   static Rows    := A_ScreenHeight // SquareSide

   ;The gui's client + the place around it it still needs
   static MarginX := A_ScreenWidth // Columns
   static MarginY := A_ScreenHeight // Rows

   ;How much client you'll get from a margin
   static ClientRelativity := 0.81

   static direction := "down"

   ;The actual visible margins of the gui
   static ClientMarginX := MarginX * ClientRelativity
   static ClientMarginY := MarginY * ClientRelativity

   static index
   static colorIndex

   stopped := false

   ChangeDirection() {
      direction := (direction = "down" ? "up" : "down")
   }

   Stop(*) => (
      startSnake.Destroy(),
      stopped := true,
      index := 0,
      colorIndex := 0
   )

   startSnake := Gui(, "Snake")
   startSnake.BackColor := "171717"

   startSnake.SetFont("s25 cC5C5C5", "Consolas")

   startSnake.Add("Text", "Center", "You can press Escape to exit the snake")

   startSnake.SetFont("s15")

   startSnake.Add("Button", "Default Center", "Start")
      .OnEvent("Click", (*) => startSnake.Destroy())
   startSnake.Add("Button", "x+m", "Cancel")
      .OnEvent("Click", Stop)

   startSnake.OnEvent("Close", Stop)

   startSnake.Show("AutoSize")
   WinWaitClose(startSnake.hwnd)

   if stopped
      return

   index := 0
   colorIndex := 0

   isSlithering := true

   SetTimer(GoSsss, delay)
   stopSlithering(*) => (
      HotIf(),
      SetTimer(GoSsss, 0),
      isSlithering := false,
      Hotkey("Escape", "Off")
   )
   HotIf()
   Hotkey("Escape", stopSlithering, "On")

   GoSsss() {

      snake := Gui("AlwaysOnTop -caption +E0x20 +ToolWindow")
      WinSetTransparent(255, snake.Hwnd)

      ;An array of ID's of guis
      static aliveSnakes := []
      aliveSnakes.Push(snake.Hwnd)

      ;An amount of guis to appear without all of them disappearing
      index++

      colorIndex++
      if colorIndex >= 7
         colorIndex := 1

      snake.Backcolor := colors[colorIndex]

      static xCoord := 0
      if index > Rows {
         index := index // Rows
         xCoord += MarginX
         if xCoord >= A_ScreenWidth - MarginX
            xCoord := 0
         ChangeDirection()
      }

      if direction = "down"
         yCoord := index * MarginY - MarginY
      else if direction = "up"
         yCoord := (Rows - index + 1) * MarginY - MarginY

      snake.Show("W " ClientMarginX " H" ClientMarginY " NA x" xCoord " y" yCoord)

      KillLastSnake := (*) => (
         SetTimer(KillLastSnake, 0),
         lastGui := aliveSnakes.RemoveAt(1),
         win_Close(lastGui)
      )
      snake.OnEvent("Close", (*) => snake.Destroy())
      SetTimer(KillLastSnake, -timeout)
   }

}

Counter(startingNum?) {
   static num := 0
   if !IsSet(startingNum) {
      Send(num++)
      return
   }
   num := startingNum
}

HoverScreenshot() {
   if !picture := FileSelect(, Paths.SavedScreenshots,, "*.png") {
      return false
   }
   gHover := Gui("AlwaysOnTop +ToolWindow -Caption")
   gcPicture := gHover.AddPicture(, picture)
   WinSetTransColor(0xF0F0F0, gHover.Hwnd)

   gHover.Show("AutoSize NA")

   gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
   gHover.OnEvent("Escape",         (guiObj)        => guiObj.Destroy())
   gcPicture.OnEvent("Click",       (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())
   return true
}

Hider(pickedColor?) {
   CoordMode("Mouse", "Screen")
   CoordMode("Pixel", "Screen")
   static color
   if IsSet(pickedColor) {
      if !pickedColor {
         MouseGetPos(&colorX, &colorY)
         color := PixelGetColor(colorX, colorY)
      } else
         color := pickedColor
      return
   }

   static firstCall := true
   static firstX, firstY
   if firstCall {
      MouseGetPos(&x, &y)
      firstX := x
      firstY := y
      firstCall := false
      return
   }

   static widthCorrecter  := 0.80
   static heightCorrecter := 0.805
   MouseGetPos(&secondX, &secondY)

   width    := Round(Abs(secondX - firstX) * widthCorrecter)
   height   := Round(Abs(secondY - firstY) * heightCorrecter)
   topLeftX := secondX > firstX ? firstX : secondX
   topLeftY := secondY > firstY ? firstY : secondY

   gHider := Gui("AlwaysOnTop -Caption -Border +ToolWindow")
   gHider.BackColor := color ?? 0x171717

   gcPicture := gHider.AddPicture("w" width " h" height, Paths.Ptf["BlankPic"])
   gcPicture.OnEvent("Click", (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())
   gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
   WinSetTransparent(1, gcPicture.Hwnd)

   gHider.Show("x" topLeftX " y" topLeftY " w" width " h" height " NA")
   firstCall := true
}

Class InternetSearch extends CleanInputBox {
   
   __New(searchEngine) {
      super.__New()
      this.SelectedSearchEngine := this.AvailableSearchEngines[searchEngine]
   }
   
   FeedQuery(input) {
      restOfLink := this.SanitizeQuery(input)
      RunLink(this.SelectedSearchEngine restOfLink)
   }
   
   DynamicallyReselectEngine(input) {
      for key, value in this.SearchEngineNicknames {
         if input.RegExMatch("^" key " ") {
            this.SelectedSearchEngine := value
            input := input[3, -1]
            break
         }
      }
      return input
   }

   TriggerSearch() {
      if !input := super.WaitForInput() {
         return false
      }
      query := this.DynamicallyReselectEngine(input)
      this.FeedQuery(query)
   }
   
   AvailableSearchEngines := Map(
      "Google",  "https://www.google.com/search?q=",
      "Youtube", "https://www.youtube.com/results?search_query=",
      "Emoji",   "https://emojipedia.org/search/?q=",
      "Yandex",  "https://yandex.ru/search/?text=",
   )
   
   SearchEngineNicknames := Map(
      "g",  this.AvailableSearchEngines["Google"],
      "y",  this.AvailableSearchEngines["Youtube"],
      "e",  this.AvailableSearchEngines["Emoji"],
      "ya", this.AvailableSearchEngines["Yandex"],
   )

   SanitizeQuery(query) { ;Rename suggestion by @Micha-ohne-el, used to be ConvertToLink()
      SpecialCharacters := '%$&+,/:;=?@ "<>#{}|\^~[]``'.Split()
      for key, value in SpecialCharacters {
         query := query.Replace(value, "%" TransfToHex(Ord(value), false))
      }
      return query
   }
}
