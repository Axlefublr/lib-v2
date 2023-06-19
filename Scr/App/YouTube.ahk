#Include <Utils\Press>
#Include <App\Youtube>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.ToggleMiniscreen()

XButton1 & r::Youtube.ToggleMiniscreen()

#HotIf