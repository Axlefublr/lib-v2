#Include <Utils\GetWeather>
#Include <Misc\RemindDate>
#Include <Tools\Info>
#Include <Utils\Win>
#Include <Abstractions\SomeLockHint>
#Include <App\Screenshot>

#InputLevel 6

#!k::Send("{WheelUp}")
#!j::Send("{WheelDown}")
#!l::Send("{PgDn}")
#!h::Send("{PgUp}")

>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next

#InputLevel 5

#^h::Win.RestoreLeftRight("left")
#^l::Win.RestoreLeftRight("right")
#^k::Win.Maximize()
#^j::Win.RestoreDown()

CapsLock::SomeLockHint("CapsLock")
#CapsLock::Win.Minimize()
!CapsLock::CloseButActually()

<!Escape::GroupDeactivate("Main")
<+Escape::Win.Minimize()
>+Escape::SomeLockHint("CapsLock")
#Escape::Infos(GetWeather()), RemindDate()

PrintScreen::Screenshot.Start()
