#Include <Utils\Press>
#Include <Utils\Win>
#Include <Abstractions\Base>
#Include <App\Youtube>
#Include <App\Spotify>
#Include <Abstractions\MediaActions>
#Include <Misc\CloseButActually>
#Include <Abstractions\WindowManager>

XButton2::return
XButton2 & d::CloseButActually()
XButton2 & e::WinMaximize("A")
XButton2 & w::WinRestore("A")
XButton2 & c::Send("{Browser_Forward}")
XButton2 & x::Send("{Browser_Back}")
XButton2 & s::WinMinimize("A")
XButton2 & v::MediaActions.SkipNext()
XButton2 & z::MediaActions.SkipPrev()