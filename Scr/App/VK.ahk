#Include <Utils\Press>
#Include <App\VK>

#HotIf WinActive(VK.winTitle)
^Enter::VK.Enter()

XButton1 & r::VK.Enter()

#HotIf