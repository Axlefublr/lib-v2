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

;; Left alt
#HotIf WinExist(Browser.Chat.winTitle)
<!t::Browser.Chat.winObj.MinMax()
#HotIf
<!s::Spotify.winObj.App()
<!a::VsCode.winObj.App()
<!c::Browser.winObj.App()
<!q::Discord.winObj.App()
<!t::Telegram.winObj.App()
<!r::Terminal.winObj.App()
<!z::VPN.winObj.App()
!F14::OBS.winObj.App()
<!x::Screenshot.Start()
<!f::Send("{WheelDown}")
<!v::Send("{WheelUp}")

;; Left shift
<+q::return
<+w::WinRestore("A")
<+e::WinMaximize("A")
<+r::Undo()
<+t::Redo()
<+a::SelectAll()
<+s::return
<+d::return
<+f::Send("{Browser_Back}")
<+g::Send("{Browser_Forward}")
<+z::Send("{F5}")
<+x::Cut()
<+c::Copy()
<+v::Paste()

;; Left shift left alt
<+<!x::Counter.Show()
<+<!c::Counter.Reset().Show()
<+<!q::Shows.SetDownloaded(Counter.num)
<+<!s::Counter.Decrement().Show()
<+<!d::Counter.Increment().Show()
<+<!f::Counter.Send().Increment()
<+<!g::Counter.Send()

;; Right alt
>!k::MouseMove(A_ScreenWidth // 20 * 19, A_ScreenHeight // 2)
>!j::Click()

;; Left windows
<#x::Screenshot.CaptureWindow()
<#c::Screenshot.CaptureScreen()
<#f::HoverScreenshot().UseRecentScreenshot().Show()

;; Right windows
>#Home::Send("{Volume_Up}")
>#End::Send("{Volume_Down}")
>#Insert::Send("{Volume_Mute}")
>#Delete::Send("{Media_Play_Pause}")
>#PgUp::MediaActions.SkipPrev()
>#PgDn::MediaActions.SkipNext()

;; Any windows
#Left::Send("{WheelLeft}")
#Right::Send("{WheelRight}")
#Up::Send("{WheelUp}")
#Down::Send("{WheelDown}")
#7::Brightness.ChangeBrightnessRelative(-10)
#8::Brightness.ChangeBrightnessRelative(10)
#s::Send("{Blind}k")
#p::Send("{Blind}i")
#HotIf !WinActive("ahk_exe " A_AhkPath)
#Space::Language.Toggle()
#HotIf
#y::WindowInfo()
#9::try HoverScreenshot().SelectPath(Paths.Pictures).Show()
#k::InternetSearch("Google").TriggerSearch()
#w::Hider(false)
#e:: {
	CoordMode("Mouse", "Screen")
	MouseGetPos(&x, &y)
	Point.Color := PixelGetColor(x, y)
}

;; Remaps
!Space::return
F13::Delete
!F13::BackSpace
#!sc27::Send("#;")
PrintScreen::Screenshot.Start()

;; Manipulation
#Tab::Send("^!{Tab}")
<+Tab::Enter
!Tab::Explorer.winObj.MinMax()
!Escape::GroupDeactivate("Main")
^Escape::CloseButActually()
<+Escape::WinMinimize("A")
>+Escape::SomeLockHint("CapsLock", 2)

;; Registers
#n::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend(CleanInputBox().WaitForInput().Replace("``n", "`n"))
#m::Registers(GetInput("L1", "{Esc}").Input).WriteOrAppend()
#!m::Registers(GetInput("L1", "{Esc}").Input).Paste()
#^m::Registers(GetInput("L1", "{Esc}").Input).Paste().Truncate()
#sc33::Registers(GetInput("L1", "{Esc}").Input).Run()
#!sc33::Registers(GetInput("L1", "{Esc}").Input).Truncate()
#sc28::Registers(GetInput("L1", "{Esc}").Input).Look()
#!sc28::Registers.PeekNonEmpty()
#!sc34::Registers(GetInput("L1", "{Esc}").Input).SwitchContents(GetInput("L1", "{Esc}").Input)