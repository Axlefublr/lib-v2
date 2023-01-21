#Include <Tools\Info>
#Include <Converters\Get>
#Include <Other>
#Include <Utils\Win>
#Include <App\Screenshot>
#Include <Tools\Counter>
#Include <Tools\Stopwatch>
#Include <Tools\CoordGetter>
#Include <Tools\KeycodeGetter>
#Include <Tools\WindowGetter>
#Include <Tools\HoverScreenshot>
#Include <Tools\InternetSearch>
#Include <System\Brightness>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\ClipSend>
#Include <Utils\KeyChorder>

#Escape::Infos(GetWeather()), RemindDate()

CapsLock::SomeLockHint("CapsLock")
+CapsLock::Win.Minimize()
!CapsLock::CloseButActually()

PrintScreen::Screenshot.Start()
#PrintScreen::Screenshot.FullScreenOut()

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

#k::key := KeyChorder(), WriteFile(Paths.Reg "\reg_" key ".txt", A_Clipboard)
#h::key := KeyChorder(), ClipSend(ReadFile(Paths.Reg "\reg_" key ".txt"))