#Include <Tools\Info>
#Include <Tools\Counter>
#Include <Tools\Stopwatch>
#Include <Tools\CoordGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowGetter>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Registers>

Pause::Counter.Increment()
+Pause::Counter.Send(), Counter.Increment()
!Pause::Counter.Decrement()
+!Pause::Counter.Reset()
^CtrlBreak::Counter.Show()

ScrollLock::Stopwatch.Start(), Info("Timer started")
!ScrollLock::Infos(Stopwatch.CurrTime)

+!f::CoordGetter()
+!g::WindowGetter()
+!v::RelativeCoordGetter()

#b::InternetSearch("Google").TriggerSearch()
#^sc1A::Brightness.ChangeBrightnessRelative(-10)
#^sc1B::Brightness.ChangeBrightnessRelative(10)

#sc33::Registers.Peek(KeyChorder())
#!sc33::Registers.Look(KeyChorder())
#sc34::Registers.PeekNonEmpty()
#sc35::Registers.Truncate(KeyChorder())
#sc28::Registers.Move(KeyChorder(), KeyChorder())
#!sc28::Registers.SwitchContents(KeyChorder(), KeyChorder())
#k::Registers.Write(KeyChorder())
#h::Registers.Paste(KeyChorder())
#j::Registers.Run(KeyChorder())