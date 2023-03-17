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

PressTitleBar(guiObj) {
    PostMessage(0xA1, 2,,, guiObj)
    return guiObj
}
Gui.Prototype.DefineProp("PressTitleBar", {Call: PressTitleBar})

NeverFocusWindow(guiObj) {
    WinSetExStyle("0x08000000L", guiObj)
    return guiObj
}
Gui.Prototype.DefineProp("NeverFocusWindow", {Call: NeverFocusWindow})

MakeClickthrough(guiObj) {
    WinSetTransparent(255, guiObj)
    guiObj.Opt("+E0x20")
    return guiObj
}
Gui.Prototype.DefineProp("MakeClickthrough", {Call: MakeClickthrough})