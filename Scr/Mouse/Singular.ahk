#Include <Abstractions\Base>
#Include <Utils\Press>
#Include <Utils\Image>
#Include <App\Screenshot>
#Include <Tools\Hider>
#Include <Abstractions\Script>

#MaxThreadsBuffer true

XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton2 & WheelUp::Press.ActOnSection("topLeft", Send.Bind("{Volume_Up}"), TransAndProud.Bind(20))
XButton2 & WheelDown::Press.ActOnSection("topLeft", Send.Bind("{Volume_Down}"), TransAndProud.Bind(-20))

XButton1 & LButton::Press.Hold_Sugar(Send.Bind("{BackSpace}"), SelectAll)
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

XButton2 & Media_Stop::Script.Reload()

#MaxThreadsBuffer false