#Include <Utils\Press>
#Include <Paths>
#Include <Abstractions\Text>
#Include <Abstractions\Base>
#Include <App\Spotify>
#Include <App\VsCode>
#Include <Converters\DateTime>
#Include <Environment>

#HotIf WinActive(Paths.Ptf["Rappers"] " " VsCode.exeTitle)
!e:: {
	text := DateTime.Date " " DateTime.Time " - " Spotify._RemoveDateAndTime(A_Clipboard)
	AppendFile(Paths.Ptf["Unfinished"], text)
	NextTab()
}

#HotIf WinActive(VsCode.winTitle)

Media_Stop & MButton::VsCode.Reload()

XButton1 & w::VsCode.CloseTab()

#HotIf