; No dependencies

GetPicInfo(picturePath) {
    gObj := Gui()
    gcPic := gObj.AddPicture(, picturePath)
    gObj.Show("Hide")
    DetectHiddenWindows(true)
    WinGetPos(,, &width, &height, gObj)
    gObj.Destroy()
    return {width: width, height: height}
}