#Include <Abstractions\GetFileTimes>

GetFilesSortedByDate(pattern, newToOld := true) {
    files := Map()
    loop files pattern {
        modificationTime := GetFileTimes(A_LoopFileFullPath).ModificationTime
        if (newToOld)
            modificationTime *= -1
        files.Set(modificationTime, A_LoopFileFullPath)
    }
    arr := []
    for , fullPath in files
        arr.Push(fullPath)
    return arr
}