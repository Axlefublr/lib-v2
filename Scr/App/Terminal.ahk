#Include <App\Terminal>

#HotIf Terminal.winObj.ActiveRegex()
^BackSpace::Terminal.DeleteWord()
#HotIf