#Include <Utils\Press>
#Include <App\Terminal>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(Terminal.winTitle)
XButton1:: {
	sections := Press.GetSections()
	MouseSectionDefaulter.VsCode(sections)
}

#HotIf