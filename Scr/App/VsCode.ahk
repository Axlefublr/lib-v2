#Include <Paths>
#Include <Abstractions\Text>
#Include <Abstractions\Base>
#Include <App\Spotify>
#Include <App\VsCode>
#Include <Converters\DateTime>
#Include <Environment>

#HotIf WinActive(Paths.Ptf["Rappers"] " ahk_exe Code.exe")
!e:: {
    text := DateTime.Date " " DateTime.Time " - " Spotify._RemoveDateAndTime(A_Clipboard)
    AppendFile(Paths.Ptf["Unfinished"], text)
    NextTab()
}

#HotIf WinActive(VsCode.winTitle)

Media_Stop & MButton::VsCode.Reload()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.right: NextTab()
        Case sections.left:  PrevTab()
        Case sections.down:  VsCode.CloseTab()
        Case sections.up:    RestoreTab()
    }
}

#HotIf
#InputLevel 5