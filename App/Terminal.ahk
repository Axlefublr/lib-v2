#Include <Utils\Win>

Class Terminal {

    static exeTitle := "ahk_exe WindowsTerminal.exe"
    static winTitle := "ahk_group Terminal"
    static path := A_ProgramFiles "\WindowsApps\Microsoft.WindowsTerminal_1.15.3465.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"

    static winTitles := Map(

        "Linux",    "Linux " this.exeTitle,
        "Cmd",      "Cmd " this.exeTitle,
        "Psh",      "PowerShell " this.exeTitle,
        "Git Bash", "Git Bash " this.exeTitle,
        "Settings", "Settings " this.exeTitle

    )
    
    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.path
    })
    
    static SetupGroup() {
        
        static ranAlready := false
        
        if ranAlready {
            return
        }

        for key, value in this.winTitles {
            GroupAdd("Terminal", value)
        }
        
        ranAlready := true
    }

    static DeleteWord() => Send("^w")
}

Terminal.SetupGroup()