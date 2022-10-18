;No dependencies

/**
 * Clicks with "Click", then moves the mouse to its initial position
 * @param coordinates *String* "123 123" format
 */
ClickThenGoBack(coordinates) {
   MouseGetPos(&initX, &initY)
   Click(coordinates)
   MouseMove(initX, initY)
}

/**
 * Clicks by SendEventing the click, then moves the mouse to its initial position
 * @param coordinates *String* "123 123" format
 */
ClickThenGoBack_Event(coordinates) {
   MouseGetPos(&initX, &initY)
   SendEvent("{Click " coordinates "}")
   MouseMove(initX, initY)
}

/**
 * Run("https://link.com") will run the link, but the browser might not get focused. This function makes sure it does
 * @param link *String*
 */
RunLink(link) => (
   Run(link),
   WinWait("Google Chrome ahk_exe chrome.exe"),
   WinActivate("Google Chrome ahk_exe chrome.exe")
)

/**
 * Keeps searching for an image until it finds it
 * @param imageFile *String* The path to the image
 * @param coordObj *Object* An optional object with x1,y1,x2,y2 properties to search for the image in
 * @returns {Array} with found X and Y coordinates
 */
WaitUntilImage(imageFile, coordObj?) {
   var := 0
   if !IsSet(coordObj) {
      coordObj := {
         x1: 0,
         y1: 0,
         x2: A_ScreenWidth,
         y2: A_ScreenHeight,
      }
   }
   SetTimer(() => var := "timed out", -5000)
   While !var {
      var := ImageSearch(&imgX, &imgY, coordObj.x1, coordObj.y1, coordObj.x2, coordObj.y2, imageFile)
   }
   if var = "timed out" {
      return false
   }
   return [imgX, imgY]
}

/**
 * Searches for an image until it finds it, and then controlclicks on it
 * @param imageFile *String* The path to the image file
 */
WaitClick(imageFile) {
   coords := WaitUntilImage(imageFile)
   if !coords
      return false
   ControlClick("X" coords[1] " Y" coords[2], "A")
}

/**
 * Change the transparency of the current window
 * @param whatCrement *Integer* Specify a negative integer to increase transparency (lower number => lower visibility)
 */
TransAndProud(whatCrement) {
   howTrans := WinGetTransparent("A")

   if !howTrans
      howTrans := 255

   etgServer := howTrans + whatCrement

   Switch {
      Case etgServer >= 255: etgServer := "Off"
      Case etgServer <= 1: etgServer := 1
   }

   try WinSetTransparent(etgServer, "A")
}

/**
 * Make the current window completely untransparent
 */
Cis() {
   try WinSetTransparent(255, "A")
}

/**
 * Syntax sugar. Write text to a file
 * @param whichFile *String* The path to the file
 * @param text *String* The text to write
 */
WriteFile(whichFile, text := "") => (
   fileObj := FileOpen(whichFile, "w"),
   fileObj.Write(text),
   fileObj.Close()
)

/**
 * Syntax sugar. Append text to a file, or write it if the file doesn't exist yet
 * @param whichFile *String* The path to the file
 * @param text *String* The text to write
 */
AppendFile(whichFile, text) {
   if FileExist(whichFile)
      fileObj := FileOpen(whichFile, "a")
   else
      fileObj := FileOpen(whichFile, "w")
   fileObj.Seek(0, 2)
   fileObj.Write(text)
   fileObj.Close()
}

/**
 * Syntax sugar. Reads a file and returns the text in it
 * @param whichFile *String* The path to the file to read
 * @returns {String}
 */
ReadFile(whichFile) {
   fileObj := FileOpen(whichFile, "r")
   fileObj.Seek(0, 0)
   text := fileObj.Read()
   fileObj.Close()
   return text
}

/**
 * Controlclicks in the current mouse position, on the active window
 * @param winTitle *String* Specify a winTitle if you don't want to use the active window
 * @param whichButton *String* L for left mouse button, R for right mouse button
 */
ControlClick_Here(winTitle := "A", whichButton := "L") => (
   MouseGetPos(&locX, &locY),
   ControlClick("X" locX " Y" locY, winTitle, , whichButton)
)

/**
 * Occupies the thread until a pixel relative to your mouse position changes color
 * @param r_RelPos *Array* Specify an array of *String* relative coordinates to check for. Format: "-5 200" or "30, -55" (so either with, or without a comma in between the x and y coordinates, depending on what you like more)
 * @param timeout *Integer* The amount of seconds until the function times out and returns false
 * @returns {Boolean} returns true if the function successfully caught the pixel color change, false in all the other situations the function might fail
 */
WaitUntilPixChange_Relative(r_RelPos, timeout := 5) {
   MouseGetPos(&locX, &locY)
   initPix := []
   endPix := []
   time := A_TickCount

   for key, value in r_RelPos {
      if !RegexMatch(value, "(-?\d+),? (-?\d+)", &init_coords)
         return false
      initPix.Push(PixelGetColor(locX + init_coords[1], locY + init_coords[2]))
   }

   Loop {
      for key, value in r_RelPos {
         if !RegexMatch(value, "(-?\d*),? (-?\d*)", &end_coords)
            return false
         endPix.Push(PixelGetColor(locX + end_coords[1], locY + end_coords[2]))
      }
      for key, value in initPix {
         if value != endPix[key]
            break 2
      }
      endPix := []
      if A_TickCount - time > timeout * 1000
         return false
   }
   return true
}

SystemReboot() => Shutdown(2)

SystemPowerDown() => Shutdown(1)

async(funcObj) => SetTimer(funcObj, -1)
