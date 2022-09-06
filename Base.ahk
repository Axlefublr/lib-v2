;No dependencies

Copy() => (
      A_Clipboard := "",
      Send("^c"),
      ClipWait(3, 1)
   )

Paste() => Send("^v")

WinPaste() => Send("#v")

Cut() => (
      A_Clipboard := "",
      Send("^x"),
      ClipWait(3, 1)
   )

SelectAll() => Send("^a")

DeleteAll() => Send("^a{Delete}")

Undo() => Send("^z")

Redo() => Send("^y")

CloseTab() => Send("^w")

NewTab() => Send("^t")

NextTab() => Send("^{PgDn}")

PrevTab() => Send("^{PgUp}")

NextWin() => Send("!{Tab}")

PrevWin() => Send("+!{Tab}")

ChooseNext() => Send("{Down}{Enter}")

SwitchLanguage() => Send("{LWin Down}{Space}{LWin Up}")

ShiftClick() => Send("+{Click}")

CtrlClick() => Send("^{Click}")

Search() => Send("^f")

AltTab() => Send("^!{Tab}")

WinTab() => Send("#{Tab}")

Save() => Send("^s")

RestoreTab() => Send("^+t")

LanguageRus() => PostMessage(0x0050, , 0x0419, , "A")

LanguageEng() => PostMessage(0x0050, , 0x0409, , "A")

DeleteWord() => Send("{Ctrl down}{Left}{Delete}{Ctrl up}")

SelectWord() => Send("{left}{ctrl down}{right}{left}{shift down}{right}{shift up}{ctrl up}")

DeleteLine() => Send("{Home}+{End}{Delete 2}")

DeleteInDirection(direction) {
   Switch direction, false {
      Case "right": direction := "{End}"
      Case "left": direction := "{Home}"
   }
   Send("+" direction "{Delete}")
}

ScreenSnip() => Send("#+s")

Find() => Send("^f")