#Include <System\System>
#Include <Abstractions\Script>

#InputLevel 6
#SuspendExempt true
#!y::Script.Suspend()
#!u::Script.Reload()
#!i::Script.Test()
#!o::Script.ExitTest()
#!p::Script.RunTests()
#Pause::System.Reboot()
Pause::System.PowerDownSafely()
#SuspendExempt false
#InputLevel 5
