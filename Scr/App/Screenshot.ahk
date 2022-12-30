#Include <App\Screenshot>
#Include <Base>

#HotIf WinActive(Screenshot.saveTitle)
XButton1 & LButton::Save()
#HotIf WinActive(Screenshot.winTitle)
WheelUp::Screenshot.Window()
WheelDown::Screenshot.Rectangle()
MButton::Screenshot.Fullscreen()
#HotIf
