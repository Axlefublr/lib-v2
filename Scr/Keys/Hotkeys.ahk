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
#Include <Utils\Wait>
#Include <Tools\Hider>
#Include <Abstractions\Base>
#Include <Abstractions\MediaActions>
#Include <Misc\CloseButActually>

#InputLevel 6

#Tab::Send("^!{Tab}")
<+<!q::return
<+<!w::WinRestore("A")
<+<!e::WinMaximize("A")
<+<!r::return
<+<!t::return
<+<!a::SelectAll()
<+<!s::MediaActions.SkipPrev()
<+<!d::MediaActions.SkipNext()
<+<!f::Send("{Browser_Back}")
<+<!g::Send("{Browser_Forward}")
<+<!z::Send("{F5}")
<+<!x::Cut()
<+<!v::Paste()
<+<!c::Copy()

<#w::Screenshot.CaptureWindow()
<#e::Screenshot.CaptureScreen()
<#f::HoverScreenshot().UseRecentScreenshot().Show()

>#Home::Send("{Volume_Up}")
>#End::Send("{Volume_Down}")
>#Insert::Send("{Volume_Mute}")
>#Delete::Send("{Media_Play_Pause}")
>#PgUp::MediaActions.SkipPrev()
>#PgDn::MediaActions.SkipNext()

F13::Delete
!F13::BackSpace

#InputLevel 5

!Tab::Explorer.winObj.MinMax()
!Escape::GroupDeactivate("Main")
<^Escape::CloseButActually()
<+Escape::WinMinimize("A")
>+Escape::SomeLockHint("CapsLock", 2)

PrintScreen::Screenshot.Start()
#HotIf !WinActive("ahk_exe " A_AhkPath)
#Space::Language.Toggle()
#HotIf

#7::Brightness.ChangeBrightnessRelative(-10)
#8::Brightness.ChangeBrightnessRelative(10)

#^LButton::CoordInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()
#y::WindowInfo()
#9::try HoverScreenshot().SelectPath(Paths.Pictures).Show()
#0::HoverScreenshot().UseRecentScreenshot().Show()
#k::InternetSearch("Google").TriggerSearch()
#w::Hider(false)
#e:: {
	CoordMode("Mouse", "Screen")
	MouseGetPos(&x, &y)
	Point.Color := PixelGetColor(x, y)
}

#n::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend(CleanInputBox().WaitForInput().Replace("``n", "`n"))
#m::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend()
#!m::Registers(GetInput("L1", "{Esc}").Input).Paste()
#^m::Registers(GetInput("L1", "{Esc}").Input).Paste().Truncate()
#sc33::Registers(GetInput("L1", "{Esc}").Input).Run()
#!sc33::Registers(GetInput("L1", "{Esc}").Input).Truncate()
#sc28::Registers(GetInput("L1", "{Esc}").Input).Look()
#!sc28::Registers.PeekNonEmpty()
#!sc34::Registers(GetInput("L1", "{Esc}").Input).SwitchContents(GetInput("L1", "{Esc}").Input)