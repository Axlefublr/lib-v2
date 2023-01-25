#Include <App\Terminal>

#HotIf WinActive(Terminal.winTitles["Linux"])
^BackSpace::Terminal.DeleteWord()
#HotIf