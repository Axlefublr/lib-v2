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
#Include <Utils\Autoclicker>

#HotIf !WinActive("ahk_exe " A_AhkPath)
#Space::Language.Toggle()
#HotIf

#!-::Counter.Decrement().Show()
#!=::Counter.Increment().Show()
#!sc1A::Counter.Send()
#!sc1B::Counter.Send().Increment()
#!sc2B:: {
    if !input := CleanInputBox().WaitForInput() {
        return
    }
    Counter.num := input
    Counter.Show()
}
#!9::Counter.Show()
#!0::Counter.Reset().Show()

#!7::Brightness.ChangeBrightnessRelative(-10)
#!8::Brightness.ChangeBrightnessRelative(10)

#c::Autoclicker()
#^LButton::CoordInfo()
#f::WindowInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()
#x::try HoverScreenshot().SelectPath(Paths.Pictures).Show()
#g::HoverScreenshot().UseRecentScreenshot().Show()

#k::InternetSearch("Google").TriggerSearch()

#n::Registers(KeyChorder()).WriteOrAppend(CleanInputBox().WaitForInput().Replace("``n", "`n"))
#m::Registers(KeyChorder()).WriteOrAppend()
#!m::Registers(KeyChorder()).Paste()
#sc33::Registers(KeyChorder()).Run()
#!sc33::Registers(KeyChorder()).Truncate()
#sc28::Registers(KeyChorder()).Look()
#!sc28::Registers.PeekNonEmpty()
#!sc34::Registers(KeyChorder()).SwitchContents(KeyChorder())