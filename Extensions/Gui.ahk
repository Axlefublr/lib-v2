;No dependencies

DarkMode(guiObj) {
   guiObj.BackColor := "171717"
   return guiObj
}
Gui.Prototype.DefineProp("DarkMode", {Call: DarkMode})

MakeFontNicer(guiObj, fontSize := 20) {
   guiObj.SetFont("s" fontSize " cC5C5C5", "Consolas")
   return guiObj
}
Gui.Prototype.DefineProp("MakeFontNicer", {Call: MakeFontNicer})

PressTitleBar(winTitle) {
   if Type(winTitle) = "Gui" {
      winTitle := winTitle.Hwnd
   }
   PostMessage(0xA1, 2,,, winTitle)
}
Gui.Prototype.DefineProp("PressTitleBar", {Call: PressTitleBar})