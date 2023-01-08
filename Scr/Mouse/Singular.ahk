#Include <Abstractions\Base>
#Include <Utils\Press>
#Include <Utils\Image>
#Include <App\Screenshot>
#Include <Loaders\Tools>
#Include <Abstractions\Script>

#MaxThreadsBuffer true

U_VerticalScroll := true
#c::global U_VerticalScroll := !U_VerticalScroll

#HotIf U_VerticalScroll
#WheelUp::WheelLeft
#WheelDown::WheelRight
#HotIf !U_VerticalScroll
WheelUp::WheelLeft
WheelDown::WheelRight
#WheelUp::WheelUp
#WheelDown::WheelDown
#HotIf

XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton2 & WheelUp::ifTopLeft_Sugar(Send.Bind("{Volume_Up}"), TransAndProud.Bind(20))
XButton2 & WheelDown::ifTopLeft_Sugar(Send.Bind("{Volume_Down}"), TransAndProud.Bind(-20))

XButton1 & LButton::press_Hold_Sugar(Send.Bind("{BackSpace}"), SelectAll)
XButton1 & RButton::Delete

XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter

XButton2 & MButton::Screenshot.FullScreenOut()
XButton1 & MButton::try HoverScreenshot().SelectPath().Show()

#!LButton::Hider(false)
#LButton::Hider()

; Media_Stop & RButton::
Media_Stop & MButton::F5
Media_Stop & LButton::Screenshot.Start()

XButton2 & Media_Stop::scr_Reload()

#MaxThreadsBuffer false