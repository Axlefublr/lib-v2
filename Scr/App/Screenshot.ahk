#Include <App\Screenshot>
#Include <Abstractions\Base>

#HotIf WinActive(Screenshot.winTitle)
WheelUp::Screenshot.Window()
WheelDown::Screenshot.Rectangle()
MButton::Screenshot.Fullscreen()
z::Screenshot.Rectangle()
x::Screenshot.FreeForm()
c::Screenshot.Window()
v::Screenshot.Fullscreen()
#HotIf
