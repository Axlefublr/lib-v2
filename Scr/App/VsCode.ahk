#Include <Paths>
#Include <Abstractions\Text>
#Include <Abstractions\Base>
#Include <App\Spotify>
#Include <App\VsCode>
#Include <Converters\DateTime>

#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
    text := DateTime.Date " " DateTime.Time " - " Spotify.RemoveDateAndTime(A_Clipboard)
    AppendFile(Paths.Ptf["Unfinished"], text)
    NextTab()
}

#HotIf WinActive(VsCode.winTitle)
Media_Stop & MButton::VsCode.Reload()
XButton1 & WheelUp::VsCode.Redo()
XButton1 & WheelDown::VsCode.Undo()
#HotIf

#InputLevel 6

#HotIf !WinActive(VsCode.winTitle)
!Insert::Cut()
^j::Find()

^!h::Send("^{Left}")
^!l::Send("^{Right}")

!j::Send("{Down}")
!k::Send("{Up}")
!h::Send("{Left}")
!l::Send("{Right}")

#HotIf

#InputLevel 5