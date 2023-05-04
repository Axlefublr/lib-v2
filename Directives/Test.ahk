#Include <Directives\Base>

#Include <Paths>
#Include <Abstractions\Text>
#Include <Tools\Info>

ExitOnWrite() {
	if !ReadFile(Paths.Ptf["test-state"]) {
		WriteFile(Paths.Ptf["test-state"], 1)
		Info("Test exited", 500)
		ExitApp()
	}
}

SetTimer(ExitOnWrite, 1000)
Info("Test running", 500)