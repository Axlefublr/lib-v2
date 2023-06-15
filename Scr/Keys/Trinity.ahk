#Include <Converters\DateTime>
#Include <App\Explorer>
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

F13::Delete
!F13::BackSpace

!Tab::GroupDeactivate("Main")
!Escape::Explorer.winObj.MinMax()
^Escape::CloseButActually()
<+Escape::WinMinimize("A")
>+Escape::SomeLockHint("CapsLock", 2)

PrintScreen::Screenshot.Start()
