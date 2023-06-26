#Include <Paths>
#Include <Abstractions\Text>

class Script {

	static Reload() => Run(A_ScriptFullPath)

	static Test() => Run(Paths.Ptf["AhkTest"])

	static ExitTest() {
		WriteFile(Paths.Ptf["test-state"], 0)
	}

}