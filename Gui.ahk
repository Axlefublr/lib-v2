;No dependencies

DarkMode(guiObj, fontSize?) {
   guiObj.BackColor := "171717"
   guiObj.SetFont("s" (fontSize ?? 20) " cC5C5C5", "Consolas")
   return guiObj
}
Gui.Prototype.DefineProp("DarkMode", {Call: DarkMode})