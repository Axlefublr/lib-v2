#Include <Tools\Hider>
#Include <Tools\Point>
#Include <Tools\CoordInfo>
#Include <Tools\RelativeCoordInfo>

#!LButton::Hider()
#LButton:: {
	While GetKeyState("LButton", "P")
		Point().Create()
}
#^LButton::CoordInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()