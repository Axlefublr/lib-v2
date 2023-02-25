#Include <App\Terminal>

#HotIf WinActive(Terminal.winTitles["Linux"])
^BackSpace::Terminal.DeleteWord()

#HotIf WinActive(Terminal.winTitle)
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