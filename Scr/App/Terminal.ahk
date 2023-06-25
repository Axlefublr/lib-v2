#Include <Utils\Press>
#Include <App\Terminal>

#HotIf Terminal.winObj.ActiveRegex()
^BackSpace::Terminal.DeleteWord()

#HotIf WinActive(Terminal.winTitle)
#HotIf