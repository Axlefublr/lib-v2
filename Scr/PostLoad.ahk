#Include <Tools\Info>
#Include <Extensions\String>
#Include <App\Autohotkey>
#Include <Misc\RemindDate>

Info(A_AhkPath.Replace(AutoHotkey.path "\"))
RemindDate()
Timer.RestartTimers()