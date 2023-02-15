#Include <Paths>
#Include <Abstractions\Text>
#Include <Abstractions\Base>
#Include <App\Spotify>
#Include <App\VsCode>
#Include <Converters\DateTime>
#Include <Environment>

#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
    text := DateTime.Date " " DateTime.Time " - " Spotify.RemoveDateAndTime(A_Clipboard)
    AppendFile(Paths.Ptf["Unfinished"], text)
    NextTab()
}

#HotIf WinActive(VsCode.winTitle)
Media_Stop & MButton::VsCode.Reload()

#HotIf
#InputLevel 5