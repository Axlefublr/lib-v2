#Include <App\Autohotkey>
#Include <Abstractions\Base>

#HotIf WinActive(Autohotkey.exeTitle)
^BackSpace::DeleteWord()
#HotIf
