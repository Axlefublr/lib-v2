#Include <Directives\Base>

#Include <Paths>
#Include <Abstractions\Text>

ExitOnWrite() {
    if !ReadFile(Paths.Ptf["test-state"]) {
        WriteFile(Paths.Ptf["test-state"], 1)
        ExitApp()
    }
}

SetTimer(ExitOnWrite, 1000)