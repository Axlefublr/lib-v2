#Include <Paths>
#Include <Tools\CleanInputBox>
#Include <Abstractions\Text>

TimerLoader() {
	if !input := CleanInputBox().WaitForInput()
		return
	WriteFile(Paths.Ptf["time-agent"], input)
	Run(Paths.Ptf["Timer"])
}