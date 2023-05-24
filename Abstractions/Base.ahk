;No dependencies

Copy() {
	A_Clipboard := ""
	Send("^{Insert}")
	ClipWait(3, 1)
}

Paste() => Send("+{Insert}")

WinPaste() => Send("#v")

Cut() {
	A_Clipboard := ""
	Send("^x")
	ClipWait(3, 1)
}

SelectAll() => Send("^a")

Undo() => Send("^z")

Redo() => Send("^y")

CloseTab() => Send("^w")

NewTab() => Send("^t")

NextTab() => Send("^{PgDn}")

PrevTab() => Send("^{PgUp}")

AltTab() => Send("^!{Tab}")

Save() => Send("^s")

RestoreTab() => Send("^+t")

DeleteWord() => Send("{Ctrl down}{Left}{Delete}{Ctrl up}")