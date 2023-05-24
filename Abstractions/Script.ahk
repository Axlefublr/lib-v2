#Include <Paths>
#Include <Tools\ToggleInfo>
#Include <Abstractions\Text>

class Script {

	static Reload() => Run(A_ScriptFullPath)

	static Suspend() {
		if A_IsSuspended {
			Suspend(false)
			ToggleInfo("Script On")
		} else {
			Suspend(true)
			ToggleInfo("Script Off")
		}
	}

	static Test() => Run(Paths.Ptf["AhkTest"])

	static ExitTest() {
		WriteFile(Paths.Ptf["test-state"], 0)
	}

	static RunTests() => Run(Paths.Ptf["Tests"])

}