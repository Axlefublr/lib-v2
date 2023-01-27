; No dependencies

KeyChorder() {
	inputHookObject := InputHook("L1", "{Esc}")
	inputHookObject.Start()
	inputHookObject.Wait()
	return inputHookObject.Input
}