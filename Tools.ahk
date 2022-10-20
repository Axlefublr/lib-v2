#Include <Global>
#Include <Win>
#Include <Gui>
#Include <Info>
#Include <Get>

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

      Hotkey("1", "Off")
      Hotkey("2", "Off")
      Hotkey("3", "Off")
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

      key_SC := "sc" Format("{:x}", key_SC) ;getkey sc/vk returns a base 10 value, when both of those are actually base 16. This makes absolutely no fucking sense. So, we use format to format a base 10 integer into a base 16 int for both of them
      key_VK := "vk" Format("{:x}", key_VK)

      g_values_name.Text := key_name
      g_values_SC.Text   := key_SC
      g_values_VK.Text   := key_VK

      HotIfWinActive("ahk_id " values_hwnd) ;If a hotkey to call this function is under a #HotIf, the hotkeys created in this functions will be affected by that. So, we have to specify that they should have no condition.
      Hotkey("1", toClip.Bind(g_values_name.text), "On")
      Hotkey("2", toClip.Bind(g_values_SC.text  ), "On")
      Hotkey("3", toClip.Bind(g_values_VK.text  ), "On")

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

tool_FileSearch(caseSense := "Off") { ;Case sense is off by default, but may need to be changed to locale if you intend to search for files named not in English.

   search := InputBox("What file do you want to search for?:", "File Search")
   search_value := search.Value ;Just a rename so the InStr in the loop doesn't have to access a property and instead just checks a variable's value
   if search.Result = "Cancel" || !search_value ;code doesn't continue to run if you cancel the inputbox or don't type in anything
      return

   folder := DirSelect("C:", 6, "What folder do you want to search?:") ;"6" makes it so you can type in / paste in the path to the folder you want to choose
   if !folder {
      MsgBox("You didn't select a valid folder") ;if you fucked up the pasting of the folder (or just pressed cancel or picked nothing)
      return
   }

   if folder = "C:\"
      folder := "C:"

   if search_value ~= "[а-яА-Я]" && caseSense != "Locale" ;If your search request you just did contains russian, caseSense for the search in InStr() is automatically made to Locale, so it actually *is* case insensitive. Likely the same case for other languages with different writing systems and doesn't matter for stuff like spanish and french (just a baseless hunch)
      caseSense := "Locale"

   guiWidth := 750
   guiHeight := 350

   g_found := Gui("AlwaysOnTop +Resize", "These files match your search:")
   g_found.SetFont("s10", "Consolas")
   g_found.Add("Text", , "Right click on a result to copy its full path. Double click to open it in explorer.")
   g_found_list := g_found.Add("ListView", "W" guiWidth - 25 " H" guiHeight - 45 " Count50", ["File", "Folder", "Directory"]) ;Count50 -- we're not losing much by allocating more memory than needed, and on the other hand we improve the performance by a lot by doing so

   g_found_list.Opt("-Redraw") ;improves performance rather than keeping on adding rows and redrawing for each one of them

   ToolTip("Search in progress", 0, 0) ;to remove the worry of "did I really start the search?"

   Loop Files folder . "\*.*", "FDR" {
      /*
         "But ternary is faster!" -- No, suprisingly enough, it's not. An if with no else is faster than ternary with : "" (which you *have to* have in v2) ((better to cum in the sink than to sink in the cum))

         Because of how compiling logic works, if the first condition on the left of the && is false, everything to the right will not even be evaluated (looked at), so instead of nesting two ifs we can use the AND statement without losing any speed.
         The trend continues with the later || -- the slowest to check file will be a *file* with no extension, then a folder, then a file, then something that didn't match
      */
      if InStr(A_LoopFileName, search_value, caseSense) {
         if InStr(A_LoopFileAttrib, "D")
            g_found_list.Add(, , A_LoopFileName, A_LoopFileDir)
         else if A_LoopFileExt
            g_found_list.Add(, A_LoopFileName, , A_LoopFileDir)
      }
   }

   ToolTip()

   g_found_list.Opt("+Redraw")
   g_found_list.ModifyCol() ;it makes the columns fit the data -- @rbstrachan

   g_found_list.OnEvent("DoubleClick", ShowInFolder)
   g_found_list.OnEvent("ContextMenu", CopyFull_path.Bind(0)) ;Funniest shit I've ever seen: all the other parameters of CopyFull_path are automatically passed into the function and the *only* parameter you have to set yourself is Y. Seriously, you don't need to specify X and Y, *just* Y. *Y* does it work like that???

   g_found.Show("W" guiWidth " H" guiHeight)
   g_found.OnEvent("Size", AutoResize) ;When you resize the gui window, the new size gets passed into AutoResize, that takes care of the list that's inside the gui
   g_found.OnEvent("Close", (*) => g_found.Destroy()) ;You can pass an asterisk instead of the parameters that are expected to be here, regardless of whether you use them

   AutoResize(g_found, minMax, width, height) { ;The parameters listed here are automatically passed by the OnEvent and you have to list them regardless of whether you're gonna use them
      g_found_list.Move(, , width - 25, height - 45)
      /*
         When you resize the main gui, the listview also gets resize to have the same borders as usual.
         So, on resize, the onevent passes *what* you resized and the width and height that's now the current one.
         Then you can use that width and height to also resize the listview in relation to the gui
      */
   }

   CopyFull_path(g_found, g_found_list, Item, IsRightClick, X, Y) { ;Same goes for these parameters. The only one you have to pass is Y, for whatever reason
      if !(Item && IsRightClick) ;If you didn't right click on the row with the mouse, don't continue running the function
         return

      A_Clipboard := GetFull_path(Item)
   } ;i.e. => when you right click on a row, the full path gets copied to your clipboard

   ShowInFolder(g_found_list, RowNumber) {
      try Run("explorer.exe /select," GetFull_path(RowNumber)) ;By passing select, we achieve the cool highlighting thing when the file / folder gets opened. (You can pass command line parameters into the run function)
   }

   GetFull_path(rowInfo) {
      /*
         The OnEvent passes which row we interacted with automatically
         So we read the text that's on the row
         And concoct it to become the full path
         This is much better performance-wise than adding all the full paths to an array while adding the listviews (in the loop) and accessing it here.
         Arguably more readable too
      */

      file := g_found_list.GetText(rowInfo, 1)
      dir := g_found_list.GetText(rowInfo, 2)
      path := g_found_list.GetText(rowInfo, 3)

      return path "\" file dir ;no explanation required, it's just logic -- @rbstrachan
   }
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
      g_CrdGet.Destroy()
   )

   HotIfWinActive("ahk_id " CrdGet_hwnd)
   Hotkey("Escape", Destruction, "On")
   Hotkey("1", toClip.Bind(ScrX " " ScrY), "On")
   Hotkey("2", toClip.Bind(WinX " " WinY), "On")
   Hotkey("3", toClip.Bind(CliX " " CliY), "On")
   Hotkey("4", toClip.Bind(pixel), "On")
   Hotkey("5", toClip.Bind("'x" CliX " y" CliY "'"), "On")
   g_CrdGet.OnEvent("Close", Destruction)

   g_CrdGet.Show("AutoSize y0 x" A_ScreenWidth / 20 * 13.5)
}

tool_WindowGetter() {

   ;Getting the current window's info
   winTitle   := WinGetTitle("A")
   winTitle_regex := ConvertToRegex(winTitle)
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
   gHover := Gui("AlwaysOnTop +ToolWindow -Caption", "HoverScreenshot")
   gcPicture := gHover.AddPicture(, picture)
   WinSetTransColor(0xF0F0F0, gHover.Hwnd)

   gHover.Show("AutoSize NA")
   
   gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
   gHover.OnEvent("Escape",         (guiObj)        => guiObj.Destroy())
   gcPicture.OnEvent("Click",       (guiCtrlObj, *) => PostMessage(0xA1, 2,,, guiCtrlObj.Gui.Hwnd))
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
   
   static widthCorrecter  := 0.81
   static heightCorrecter := 0.81
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