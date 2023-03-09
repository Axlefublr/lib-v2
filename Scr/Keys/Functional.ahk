#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\CoordGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowGetter>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Registers>

+End::Counter.Decrement().Show()
+Home::Counter.Increment().Show()
+Insert::Counter.Show()
+!Insert::Counter.Reset().Show()
+PgDn::Counter.Send()
+PgUp::Counter.Send().Increment()
+!Delete:: {
    if !input := CleanInputBox().WaitForInput() {
        return
    }
    Counter.num := input
    Counter.Show()
}

+!f::CoordGetter()
+!g::WindowGetter()
+!v::RelativeCoordGetter()

#k::InternetSearch("Google").TriggerSearch()
#^sc1A::Brightness.ChangeBrightnessRelative(-10)
#^sc1B::Brightness.ChangeBrightnessRelative(10)

#m::Registers(KeyChorder()).WriteOrAppend()
#!m::Registers(KeyChorder()).Paste()
#sc33::Registers(KeyChorder()).Run()
#!sc33::Registers(KeyChorder()).Truncate()
#sc28::Registers(KeyChorder()).Look()
#!sc28::Registers.PeekNonEmpty()
#^sc28::Registers(KeyChorder()).SwitchContents(KeyChorder())