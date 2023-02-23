#Include <App\ClockApp>
#Include <System\UIA>

#HotIf WinActive(ClockApp.winTitle) && ClockApp.IsStopwatchActive
Space::ClockApp.UIA.StartButton.Click()
r::ClockApp.UIA.ResetButton.Click()
#HotIf