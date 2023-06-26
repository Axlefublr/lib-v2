#Include <App\Explorer>
#Include <Abstractions\Base>
#Include <Tools\FileSystemSearch>

#HotIf WinActive(Explorer.exeTitle)
^BackSpace::DeleteWord()
#HotIf
