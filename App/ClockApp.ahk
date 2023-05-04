; No dependencies

class ClockApp {

	static exeTitle := "ahk_exe ApplicationFrameHost.exe"
	static winTitle := "Clock " ClockApp.exeTitle
	static path := "shell:Appsfolder\Microsoft.WindowsAlarms_8wekyb3d8bbwe!App"

	static winObj := Win({
		winTitle: ClockApp.winTitle,
		exePath:  ClockApp.path
	})

	static IsStopwatchActive {
		get => ClockApp.UIA.StopwatchElement.IsSelected
	}

	class UIA {

		static MainElement {
			get => UIA.ElementFromHandle(ClockApp.winTitle).FindElement({
				Type: "Window",
				ClassName: "Windows.UI.Core.CoreWindow",
				Name: "Clock",
				Scope: 2,
				Order: 2
			}).FindElement({
				AutomationId: "NavView",
				Scope: 2
			})
		}

		static MainPane {
			get => ClockApp.UIA.MainElement.FindElement({
				Type: "Pane",
				Scope: 2
			})
		}

		static TabList {
			get => ClockApp.UIA.MainElement.FindElement({
				Type: "Window",
				Scope: 2
			}).FindElement({
				AutomationId: "MenuItemsScrollViewer",
				Scope: 2
			}).FindElement({
				AutomationId: "MenuItemsHost"
			})
		}

		static StopwatchElement {
			get => ClockApp.UIA.TabList.FindElement({
				AutomationId: "StopwatchButton"
			})
		}

		static ToolGroup {
			get => ClockApp.UIA.MainPane.FindElement({
				ClassName: "NamedContainerAutomationPeer",
				Scope: 2,
				Order: 2
			})
		}

		static StartButton {
			get => ClockApp.UIA.ToolGroup.FindElement({
				AutomationId: "StopwatchPlayPauseButton"
			})
		}

		static ResetButton {
			get => ClockApp.UIA.ToolGroup.FindElement({
				AutomationId: "StopWatchResetButton"
			})
		}

	}

}