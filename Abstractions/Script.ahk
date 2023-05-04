#Include <Paths>
#Include <Tools\ToggleInfo>

class Script {

	static Reload() => Run(A_ScriptFullPath)

	static HardReload() {

		_onExit(ExitReason, ExitCode) {
			if ExitReason = "Exit" {
				Run(A_ScriptFullPath)
			}
		}

		ExitApp()
	}

	static Suspend() {
		if A_IsSuspended {
			Suspend(false)
			ToggleInfo("Script On")
		} else {
			Suspend(true)
			ToggleInfo("Script Off")
		}
	}

	static RunAsAdmin() {
		if !A_IsAdmin {
			Run('*RunAs "' A_ScriptFullPath '"')
			Sleep(10000)
			;Even though we just ran a new instance of the same script that's currently running, it might still partly reach the following line, here we make sure nothing even tries to happen before we properly rerun the current script as admin. This sleep doesn't actually introduce any delay, it's purely for smoothness.
		}
	}

	static Test() => Run(Paths.Ptf["AhkTest"])

	static ExitTest() {
		WriteFile(Paths.Ptf["test-state"], 0)
	}

	static RunTests() => Run(Paths.Ptf["Tests"])

}