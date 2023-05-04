; No dependencies

GetInput(options?, endKeys?) {
	inputHookObject := InputHook(options?, endKeys?)
	inputHookObject.Start()
	inputHookObject.Wait()
	return inputHookObject
}