#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\CoordGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowGetter>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Registers>

+!f::CoordGetter()
+!g::WindowGetter()
+!v::RelativeCoordGetter()

#k::InternetSearch("Google").TriggerSearch()
#^sc1A::Brightness.ChangeBrightnessRelative(-10)
#^sc1B::Brightness.ChangeBrightnessRelative(10)

#sc33::Registers(KeyChorder()).Paste()
#!sc33::Registers(KeyChorder()).Run()
#sc28::Registers(KeyChorder()).Look()
#!sc28::Registers.PeekNonEmpty()
#m::Registers(KeyChorder()).WriteOrAppend()
#!m::Registers(KeyChorder()).Truncate()
#^sc28::Registers(KeyChorder()).SwitchContents(KeyChorder())