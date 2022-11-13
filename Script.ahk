#Include <Global>
#Include <Paths>
#Include <Tools\Info>

;Reloads the script
scr_Reload() => Run(A_ScriptFullPath)

;Hard reloads the script: exits the script and then runs it, instead of just running over itself like _scr_Reload does.
scr_HardReload() {

   _onExit(ExitReason, ExitCode) {
      if ExitReason = "Exit" {
         Run(A_ScriptFullPath)
      }
   }

   ExitApp()
}

;Suspends or unsuspends the script
scr_Suspend() {
   if A_IsSuspended {
      Suspend(false)
      ToggleInfo("Script On")
   } else {
      Suspend(true)
      ToggleInfo("Script Off")
   }
}

scr_RunAsAdmin() {
   if !A_IsAdmin {
      Run('*RunAs "' A_ScriptFullPath '"')
      Sleep(10000)
      ;Even though we just ran a new instance of the same script that's currently running, it might still partly reach the following line, here we make sure nothing even tries to happen before we properly rerun the current script as admin. This sleep doesn't actually introduce any delay, it's purely for smoothness.
   }
}

scr_Test() => Run(Paths.Ptf["AhkTest"])

scr_ExitTest() {
   DetectHiddenWindows(true)
   PostMessage(0x5555, 11, 22,, "ahk_class AutoHotkey")
}

;Alternative to outputdebug
Out(put := "", endChar := "`n", overwrite := false) {
   filePath := Paths.Ptf["Output"]
   static wasRan := false
   if !wasRan || overwrite
      WriteFile(filePath, put endChar), wasRan := true
   else
      AppendFile(filePath, put endChar)
}