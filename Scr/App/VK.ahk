#Include <Utils\Press>
#Include <App\VK>

#HotIf WinActive(VK.winTitle)
^Enter::VK.Enter()

XButton1 & f::VK.Enter()

#HotIf