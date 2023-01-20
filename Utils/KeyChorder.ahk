; No dependencies

KeyChorder() {
   inputHookObject := InputHook("L1")
   inputHookObject.Start()
   inputHookObject.Wait()
   return inputHookObject.Input
}