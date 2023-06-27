#Include <Tools\Hider>
#Include <Tools\Point>
#Include <Tools\CoordInfo>
#Include <Tools\RelativeCoordInfo>

#MaxThreadsBuffer true
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down
#MaxThreadsBuffer false

XButton1 & XButton2::Media_Play_Pause
XButton2 & XButton1::Escape

#!LButton::Hider()
#LButton:: {
	While GetKeyState("LButton", "P")
		Point().Create()
}
#^LButton::CoordInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()