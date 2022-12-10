#Include <Global>
#Include <Win>
#Include <Gui>
#Include <Get>
#Include <String>

#Include <Tools\Info>
#Include <Tools\CleanInputBox>
#Include <Tools\CoordGetter>
#Include <Tools\FileSystemSearch>
#Include <Tools\InternetSearch>
#Include <Tools\Timer>
#Include <Tools\WindowGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\Counter>

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
      "D12229", ;Red
      "F68A1E", ;Orange
      "FDE01A", ;Yellow
      "007940", ;Green
      "24408E", ;Blue
      "732982"  ;Purple
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

   ChangeDirection() => direction := (direction = "down" ? "up" : "down")

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
         Win({winTitle: lastGui}).Close()
      )
      snake.OnEvent("Close", (*) => snake.Destroy())
      SetTimer(KillLastSnake, -timeout)
   }

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
