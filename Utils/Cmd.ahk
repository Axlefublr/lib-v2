;No dependencies

class Cmd {

    __New(workingDir := A_WorkingDir) {
        PID := this._CreateConsoleWindow()
        this._AttachConsole(PID)
        this.shell := ComObject("WScript.Shell")
        this.shell.CurrentDirectory := workingDir
    }

    __Delete() {
        this._FreeConsole()
    }


    StdOut {
        get => Trim(this.exec.StdOut.ReadAll(), "`r`n`t ")
    }


    Execute(commands*) {
        commands := this._GetCommandString(commands)
        this.exec := this.shell.Exec(A_ComSpec " /C " commands)
        While !this.exec.Status {
            Sleep(50)
        }
        return this
    }


    exec := unset


    _CreateConsoleWindow() {
        DetectHiddenWindows(True)
        Run(A_ComSpec,, "Hide", &PID)
        while !WinExist("ahk_pid " PID) {
            Sleep(50)
        }
        return PID
    }

    _GetCommandString(commands) {
        commandString := ""
        for index, command in commands {
            if index = commands.Length {
                commandString .= command
                break
            }
            commandString .= command " && "
        }
        return commandString
    }

    _AttachConsole(PID) => DllCall("kernel32.dll\AttachConsole", "UInt", PID)

    _FreeConsole() => DllCall("kernel32.dll\FreeConsole")


    /**
     * Syntax sugar: "Run *this* using *this program*"
     * @param with *String* The program to use to run something with: either Program.exe format, or the full path to the executable
     * @param runFile *String* The path to the file (or link!) you want to run
     */
    static RunWith(with, runFile) => Run(with ' "' runFile '"')

}