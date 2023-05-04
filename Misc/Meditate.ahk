; No dependencies

Meditate(timeInMinutes := 20) {
	SetTimer(Send.Bind("{Media_Stop}"), -timeInMinutes * 60 * 1000)
	Info("Music will be turned off in " timeInMinutes " minutes")
}