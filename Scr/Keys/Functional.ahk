#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\Stopwatch>
#Include <Tools\CoordGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowGetter>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Registers>

; Pause::Counter.Increment()
; +Pause::Counter.Send(), Counter.Increment()
; !Pause::Counter.Decrement()
; +!Pause::Counter.Reset()
; ^CtrlBreak::Counter.Show()

+!f::CoordGetter()
+!g::WindowGetter()
+!v::RelativeCoordGetter()

#k::InternetSearch("Google").TriggerSearch()
#^sc1A::Brightness.ChangeBrightnessRelative(-10)
#^sc1B::Brightness.ChangeBrightnessRelative(10)

#n::Registers.Paste(KeyChorder())
#!n::Registers.Run(KeyChorder())
#b::Registers.Look(KeyChorder())
#!b::Registers.PeekNonEmpty()
#m::Registers.WriteOrAppend(KeyChorder())
#!m::Registers.Truncate(KeyChorder())