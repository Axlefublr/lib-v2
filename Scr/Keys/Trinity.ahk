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

Home::Send("{Volume_Up}")
End::Send("{Volume_Down}")
Insert::Send("{Volume_Mute}")
Delete::Send("{Media_Play_Pause}")
PgUp::Send("{Media_Prev}")
Pgdn::Send("{Media_Next}")

#InputLevel 5

#^h::Win.RestoreLeftRight("left")
#^l::Win.RestoreLeftRight("right")
#^k::Win.Maximize()
#^j::Win.RestoreDown()

CapsLock::Delete
!CapsLock::CloseButActually()
+CapsLock::Win.Minimize()

<!Escape::GroupDeactivate("Main")
<+Escape:: {
    SetTitleMatchMode("Regex")
    Explorer.winObjRegex.MinMax()
}
>+Escape::SomeLockHint("CapsLock")
#Escape::Infos(GetWeather()), RemindDate()

PrintScreen::Screenshot.Start()
