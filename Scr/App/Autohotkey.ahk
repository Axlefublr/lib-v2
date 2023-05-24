#Include <App\Autohotkey>
#Include <Abstractions\Base>

#HotIf WinActive(Autohotkey.exeTitle)
^BackSpace::DeleteWord()

#HotIf WinActive(Autohotkey.Docs.winTitle)
!sc33::Send("!n")
!sc34::Send("!s")
#HotIf
