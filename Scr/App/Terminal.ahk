#Include <App\Terminal>

#HotIf WinActive(Terminal.winTitle)
^BackSpace::Terminal.DeleteWord()
#HotIf