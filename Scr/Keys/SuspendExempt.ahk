#Include <System\System>
#Include <Abstractions\Script>

#InputLevel 6
#SuspendExempt true
#!y::Script.Suspend()
#!u::Script.Reload()
#!i::Script.Test()
#!o::Script.ExitTest()
#!p::Script.RunTests()
#F14::System.Reboot()
F14::System.PowerDownSafely()
#SuspendExempt false
#InputLevel 5
