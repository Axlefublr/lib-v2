#Include <Utils\Win>

Class Player {
    static exeTitle := "ahk_exe KMPlayer64.exe"
    static winTitle := this.exeTitle

    static winObj := Win({winTitle: this.winTitle})
}