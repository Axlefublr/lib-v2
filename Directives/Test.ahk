#Include <Directives\Base>
#Hotstring EndChars `t
CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Client")
OnMessage(0x5555, (*) => ExitApp())
#Include <Loaders/All>