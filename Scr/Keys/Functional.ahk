#Include <Abstractions\Mouse>
#Include <Abstractions\WindowManager>
#Include <Utils\GetInput>
#Include <Tools\HoverScreenshot>
#Include <Extensions\String>
#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\CoordInfo>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowInfo>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Registers>
#Include <Tools\RelativeCoordInfo>
#Include <System\Language>

#HotIf !WinActive("ahk_exe " A_AhkPath)
#Space::Language.Toggle()
#HotIf

#7::Brightness.ChangeBrightnessRelative(-10)
#8::Brightness.ChangeBrightnessRelative(10)

#s::WindowManager().SetHalfWidth().SetFullHeight().AbsoluteMove(0, 0)
#d::WindowManager().SetFullWidth().SetHalfHeight().AbsoluteMove(0, 0)
#f::WindowManager().SetFullWidth().SetHalfHeight().AbsoluteMove(0, Mouse.MiddleY)
#g::WindowManager().SetHalfWidth().SetFullHeight().AbsoluteMove(Mouse.MiddleX, 0)

#a::WindowManager().SetHalfWidth().SetHalfHeight().AbsoluteMove(0, Mouse.MiddleY)
#q::WindowManager().SetHalfWidth().SetHalfHeight().AbsoluteMove(0, 0)
#w::WindowManager().SetHalfWidth().SetHalfHeight().AbsoluteMove(Mouse.MiddleX, Mouse.MiddleY)
#e::WindowManager().SetHalfWidth().SetHalfHeight().AbsoluteMove(Mouse.MiddleX, 0)

#^LButton::CoordInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()
#y::WindowInfo()
#9::try HoverScreenshot().SelectPath(Paths.Pictures).Show()
#0::HoverScreenshot().UseRecentScreenshot().Show()
#k::InternetSearch("Google").TriggerSearch()

#n::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend(CleanInputBox().WaitForInput().Replace("``n", "`n"))
#m::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend()
#!m::Registers(GetInput("L1", "{Esc}").Input).Paste()
#^m::Registers(GetInput("L1", "{Esc}").Input).Paste().Truncate()
#sc33::Registers(GetInput("L1", "{Esc}").Input).Run()
#!sc33::Registers(GetInput("L1", "{Esc}").Input).Truncate()
#sc28::Registers(GetInput("L1", "{Esc}").Input).Look()
#!sc28::Registers.PeekNonEmpty()
#!sc34::Registers(GetInput("L1", "{Esc}").Input).SwitchContents(GetInput("L1", "{Esc}").Input)