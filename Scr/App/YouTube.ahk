#Include <Utils\Press>
#Include <App\Youtube>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.ToggleMiniscreen()

XButton1 & f::Youtube.ToggleMiniscreen()

#HotIf