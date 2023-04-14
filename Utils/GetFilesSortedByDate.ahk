#Include <Abstractions\GetFileModificationTime>

GetFilesSortedByDate(pattern, newToOld := true) {
    files := Map()
    loop files pattern {
        modificationTime := GetFileModificationTime(A_LoopFileFullPath)
        if (newToOld)
            modificationTime *= -1
        files.Set(modificationTime, A_LoopFileFullPath)
    }
    arr := []
    for , fullPath in files
        arr.Push(fullPath)
    return arr
}