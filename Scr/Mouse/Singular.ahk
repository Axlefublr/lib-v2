#Include <Utils\Autoclicker>
#Include <Abstractions\Base>
#Include <Utils\Press>
#Include <Utils\Image>
#Include <App\Screenshot>
#Include <Tools\Hider>
#Include <Abstractions\Script>
#Include <Tools\Point>
#Include <Tools\HoverScreenshot>

#MaxThreadsBuffer true

XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down

XButton1 & WheelUp::Redo()
XButton1 & WheelDown::Undo()

XButton1 & LButton::BackSpace
XButton1 & RButton::Delete

XButton2 & LButton::Screenshot.winObj.RunAct()
XButton2 & RButton::Enter

+!LButton::AutoClicker()
#!LButton::Hider()
#LButton:: {
	While GetKeyState("LButton", "P")
		Point().Create()
}

#MaxThreadsBuffer false