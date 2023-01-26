#Include <Paths>
#Include <Abstractions\Text>

;Alternative to outputdebug
Out(put := "", endChar := "`n", overwrite := false) {
	filePath := Paths.GetRegPath("o")
	static wasRan := false
	if !wasRan || overwrite
		WriteFile(filePath, put endChar), wasRan := true
	else
		AppendFile(filePath, put endChar)
}