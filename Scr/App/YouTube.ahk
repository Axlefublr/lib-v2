#Include <Utils\Press>
#Include <App\Youtube>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.ToggleMiniscreen()

XButton1:: {
	sections := Press.GetSections()
	Switch {
		Case sections.bottomLeft: Youtube.ToggleMiniscreen()
		default:                  MouseSectionDefaulter.Browser(sections)
	}
}

#HotIf