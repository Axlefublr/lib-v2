#Include <Abstractions\Script>

#InputLevel 6
#SuspendExempt true
#!y::Script.Suspend()
#!u::Script.Reload()
#!i::Script.Test()
#!o::Script.ExitTest()
#ScrollLock::SystemReboot()
#Pause::Run(Paths.Apps["Slide to shutdown"])
#SuspendExempt false
#InputLevel 5
