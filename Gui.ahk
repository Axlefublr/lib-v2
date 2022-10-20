;No dependencies

DarkMode(guiObj, fontSize?) {
   guiObj.BackColor := "171717"
   guiObj.SetFont("s" (fontSize ?? 20) " cC5C5C5", "Consolas")
   return guiObj
}
Gui.Prototype.DefineProp("DarkMode", {Call: DarkMode})

PressTitleBar(guiObj) {
   PostMessage(0xA1, 2,,, guiObj.Hwnd)
}
Gui.Prototype.DefineProp("PressTitleBar", {Call: PressTitleBar})