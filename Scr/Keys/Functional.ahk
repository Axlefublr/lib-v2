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

#sc35::key := KeyChorder(), WriteFile(Paths.GetRegPath(key))
#sc28:: {
   key := KeyChorder()
   registerContents := ReadFile(Paths.GetRegPath(key))
   registerContentsNoNewlines := registerContents.RegExReplace("\r?\n", "\n")
   shorterRegisterContents := registerContentsNoNewlines[1, 100]
   Infos(shorterRegisterContents)
}
#k::key := KeyChorder(), WriteFile(Paths.GetRegPath(key), A_Clipboard)
#h::key := KeyChorder(), ClipSend(ReadFile(Paths.GetRegPath(key)))
#j::key := KeyChorder(), Run(ReadFile(Paths.GetRegPath(key)))