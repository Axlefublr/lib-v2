#Include <System\System>
#Include <Abstractions\Script>

#InputLevel 6
#SuspendExempt true
#!y::Script.Suspend()
#!u::Script.Reload()
#!i::Script.Test()
#!o::Script.ExitTest()
#ScrollLock::System.Reboot()
#Pause::System.PowerDownSafely()
#SuspendExempt false
#InputLevel 5
