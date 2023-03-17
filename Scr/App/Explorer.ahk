#Include <App\Explorer>
#Include <Abstractions\Base>
#Include <Tools\FileSystemSearch>

#HotIf WinActive(Explorer.exeTitle)
F6::FileSystemSearch().GetInput()
^BackSpace::DeleteWord()
#HotIf
