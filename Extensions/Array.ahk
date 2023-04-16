; No dependencies

_ArrayToString(this) {
    str := "[ "
    for index, value in this {
        if index = this.Length {
            str .= value " "
            break
        }
        str .= value ", "
    }
    str .= "]"
    return str
}
Array.Prototype.DefineProp("ToString", { Call: _ArrayToString })