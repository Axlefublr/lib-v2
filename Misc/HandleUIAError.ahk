; No dependencies

HandleUIAError(funcObj) {
	try funcObj.Call()
	catch {
		Info("Action failed")
	}
}