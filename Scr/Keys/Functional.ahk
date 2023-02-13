#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\Stopwatch>
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

#n::Registers(KeyChorder()).Paste()
#!n::Registers(KeyChorder()).Run()
#b::Registers(KeyChorder()).Look()
#!b::Registers.PeekNonEmpty()
#m::Registers(KeyChorder()).WriteOrAppend()
#!m::Registers(KeyChorder()).Truncate()