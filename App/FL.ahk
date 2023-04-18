#Include <Utils\Win>
#Include <Paths>

Class FL {

    static exeTitle := "ahk_exe FL64.exe"
    static winTitle := this.exeTitle
    static path := "C:\Programs\FL Studio 20\FL64.exe"
    static closeWindow := "Confirm " this.exeTitle

    static winObj := Win({
        winTitle: this.exeTitle,
        exePath: this.path
    })

    static Close() {
        this.winObj.Close()
        if !WinWait(this.closeWindow,, this.winObj.waitTime)
            return
        Win({winTitle: this.closeWindow}).Activate()
        Send("{Right}{Enter}")
    }
}