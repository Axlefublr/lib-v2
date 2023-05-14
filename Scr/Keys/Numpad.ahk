#Include <Tools\StateBulb>
#Include <Abstractions\SomeLockHint>
#Include <App\Screenshot>
#Include <App\OBS>
#Include <Utils\Win>
#Include <System\System>

NumLock::SomeLockHint("NumLock", 6)

*NumpadHome::return
NumpadHome::Screenshot.Start()
!NumpadHome::Screenshot.CaptureWindow()
+NumpadHome::Screenshot.CaptureScreen()

!NumpadUp::OBS.winObj.App()
#NumpadPgup::System.Reboot()
NumpadPgup::System.PowerDownSafely()

NumpadClear::Volume_Up
NumpadDown::Volume_Down
NumpadLeft::Volume_Mute
NumpadRight::MediaActions.SkipPrev()
NumpadPgdn::MediaActions.SkipNext()
NumpadEnd::Send("{Media_Play_Pause}")