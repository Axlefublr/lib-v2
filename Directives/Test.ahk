#Include <Directives\Base>
#Hotstring EndChars `t
CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Client")
#Include <Loaders/All>

ExitOnWrite() {
    if !ReadFile(Paths.Ptf["test-state"]) {
        WriteFile(Paths.Ptf["test-state"], 1)
        ExitApp()
    }
}

SetTimer(ExitOnWrite, 1000)