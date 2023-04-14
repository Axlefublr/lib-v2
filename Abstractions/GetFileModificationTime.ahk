; No dependencies

GetFileModificationTime(filePath) {
    oFile := FileOpen(filePath, 0x700)
    DllCall("GetFileTime", "Ptr", oFile.Handle, "Ptr", 0, "Ptr", 0, "Int64*", &modificationTime := 0)
    return modificationTime
}