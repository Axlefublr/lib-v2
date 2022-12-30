#Include <App\Explorer>
#Include <Base>

#HotIf WinActive(Explorer.exeTitle)
F6::FileSystemSearch().GetInput()
^BackSpace::DeleteWord()
#HotIf
