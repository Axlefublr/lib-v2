#Include <Paths>
#Include <Abstractions\Text>

;Alternative to outputdebug
Out(put := "", endChar := "`n", overwrite := false) {
	static wasRan := false
	static path := Registers.GetPath("o")
	if !wasRan || overwrite
		WriteFile(path, put endChar), wasRan := true
	else
		AppendFile(path, put endChar)
}