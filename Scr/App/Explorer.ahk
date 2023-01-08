#Include <App\Explorer>
#Include <Abstractions\Base>

#HotIf WinActive(Explorer.exeTitle)
F6::FileSystemSearch().GetInput()
^BackSpace::DeleteWord()
#HotIf
