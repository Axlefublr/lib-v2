#Requires AutoHotkey v2.0
#SingleInstance Force
#WinActivateForce
#InputLevel 5
#HotIf
A_MaxHotkeysPerInterval := 1000
SetWorkingDir A_ScriptDir
SetControlDelay(-1)
SetWinDelay(-1)
SetDefaultMouseSpeed(0)
#Hotstring EndChars @
#Hotstring t o
CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Client")
Thread("Priority", 10)
