#Include <Utils\GetWeather>
#Include <Misc\RemindDate>
#Include <Tools\Info>
#Include <Utils\Win>
#Include <Abstractions\SomeLockHint>
#Include <App\Screenshot>
#Include <Abstractions\MediaActions>
#Include <Misc\CloseButActually>

#InputLevel 6

Home::Volume_Up
End::Volume_Down
Insert::Volume_Mute
PgUp::MediaActions.SkipPrev()
PgDn::MediaActions.SkipNext()
Delete::Send("{Media_Play_Pause}")

#InputLevel 5

#!h::Win.RestoreLeftRight("left")
#!l::Win.RestoreLeftRight("right")
#!k::Win.Maximize()
#!j::Win.RestoreDown()

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
