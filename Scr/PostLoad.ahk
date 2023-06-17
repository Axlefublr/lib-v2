#Include <Tools\Info>
#Include <Extensions\String>
#Include <App\Autohotkey>
#Include <Misc\RemindDate>
#Include <Utils\GetWeather>

SetNumLockState(true)
Info(A_AhkPath.Replace(AutoHotkey.path "\"))
RemindDate()