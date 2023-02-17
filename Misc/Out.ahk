#Include <Paths>
#Include <Abstractions\Text>

;Alternative to outputdebug
Out(put := "", endChar := "`n", overwrite := false) {
    static wasRan := false
    if !wasRan || overwrite
        Registers("o").Write(put endChar), wasRan := true
    else
        Registers("o").Append(put endChar)
}