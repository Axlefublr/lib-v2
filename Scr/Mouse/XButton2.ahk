#Include <Utils\Press>
#Include <Utils\Win>
#Include <Abstractions\Base>
#Include <App\Youtube>
#Include <App\Spotify>
#Include <Abstractions\MediaActions>
#Include <Misc\CloseButActually>
#Include <Abstractions\WindowManager>

XButton2::return
#HotIf GetKeyState("XButton2", "P")
q::Script.Reload()
w::WinRestore("A")
e::WinMaximize("A")
r::MediaActions.SkipPrev()
+r::Send("{F5}")
t::MediaActions.SkipNext()
a::SelectAll()
s::WinMinimize("A")
d::CloseButActually()
f::Browser_Back
g::Browser_Forward
z::Script.Test()
x::Cut()
c::Copy()
v::Paste()
3::Screenshot.CaptureWindow()
4::Screenshot.CaptureScreen()
5::HoverScreenshot().UseRecentScreenshot().Show()
#HotIf