#Include <System\System>
#Include <Abstractions\Script>

#InputLevel 6
#SuspendExempt true
#!u::Script.Reload()
#!i::Script.Test()
#!o::Script.ExitTest()
#Pause::System.Reboot()
Pause::System.PowerDownSafely()
#SuspendExempt false
#InputLevel 5