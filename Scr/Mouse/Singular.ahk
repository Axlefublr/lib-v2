#Include <Abstractions\Base>
#Include <Utils\Press>
#Include <Utils\Image>
#Include <App\Screenshot>
#Include <Tools\Hider>
#Include <Abstractions\Script>
#Include <Tools\Point>

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
#LButton:: {
    While GetKeyState("LButton", "P")
        Point().Create()
}

#HotIf GetKeyState("Ctrl", "P")
Media_Stop & XButton1::Cut()
#HotIf

Media_Stop & XButton1::Copy()
Media_Stop & XButton2::Paste()

; Media_Stop & RButton::return
Media_Stop & MButton::F5
; Media_Stop & LButton::return

XButton1 & Media_Stop::Script.Test()
XButton2 & Media_Stop::Script.Reload()

#MaxThreadsBuffer false