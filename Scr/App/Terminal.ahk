#Include <App\Terminal>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(Terminal.winTitles["Linux"])
^BackSpace::Terminal.DeleteWord()

#HotIf WinActive(Terminal.winTitle)
XButton1:: {
    sections := Press.GetSections()
    MouseSectionDefaulter.VsCode(sections)
}

#HotIf