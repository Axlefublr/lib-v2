#Include <BaseDirectives>
#Hotstring EndChars `t 
CoordMode("Mouse", "Screen") 
SetControlDelay(-1) 
KeyHistory(0) 
A_MaxHotkeysPerInterval := 1000 
SetWorkingDir A_ScriptDir "\..\" 
OnMessage(0x5555, (*) => ExitApp())
#Include <All>