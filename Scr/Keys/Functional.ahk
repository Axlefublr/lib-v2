#Include <Utils\KeyChorder>
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

#sc1A::Brightness.ChangeBrightnessRelative(-10)
#sc1B::Brightness.ChangeBrightnessRelative(10)

#^LButton::CoordInfo()
#+LButton::RelativeCoordInfo.BetterCallThis()
#y::WindowInfo()
#x::try HoverScreenshot().SelectPath(Paths.Pictures).Show()
#u:: {
    HoverScreenshot().UseRecentScreenshot().Show().gHover.PressTitleBar()
    Environ
}

#k::InternetSearch("Google").TriggerSearch()

#n::Registers(KeyChorder()).WriteOrAppend(CleanInputBox().WaitForInput().Replace("``n", "`n"))
#m::Registers(KeyChorder()).WriteOrAppend()
#!m::Registers(KeyChorder()).Paste()
#^m::Registers(KeyChorder()).Paste().Truncate()
#sc33::Registers(KeyChorder()).Run()
#!sc33::Registers(KeyChorder()).Truncate()
#sc28::Registers(KeyChorder()).Look()
#!sc28::Registers.PeekNonEmpty()
#!sc34::Registers(KeyChorder()).SwitchContents(KeyChorder())