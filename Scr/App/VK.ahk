#Include <App\VK>

#HotIf WinActive(VK.winTitle)
MButton::VK.Reply()
^Enter::VK.Enter()
#HotIf