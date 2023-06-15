#Include <Utils\Press>
#Include <App\Terminal>

#HotIf Terminal.winObj.ActiveRegex()
^BackSpace::Terminal.DeleteWord()

#HotIf WinActive(Terminal.winTitle)
XButton1 & w::VsCode.CloseTab()

#HotIf