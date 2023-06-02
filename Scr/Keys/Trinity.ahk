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
!F13::CloseButActually()
+F13::WinMinimize("A")

<!Escape::GroupDeactivate("Main")
<+Escape::Explorer.winObj.MinMax()
>+Escape::SomeLockHint("CapsLock", 2)
#Escape::Infos(GetWeather()), RemindDate(), Infos(DateTime.Date " " DateTime.WeekDay " " DateTime.Time)

PrintScreen::Screenshot.Start()
