#Include <App\Autohotkey>
#Include <Base>

#HotIf WinActive(Autohotkey.exeTitle)
^BackSpace::DeleteWord()

#HotIf WinActive(Autohotkey.Docs.v2.winTitle)
!sc33::Send("!n")
!sc34::Send("!s")
#HotIf
