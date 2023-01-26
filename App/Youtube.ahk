#Include <Utils\Image>

Class Youtube {

	static winTitle := "YouTube ahk_exe chrome.exe"

	static Studio := "YouTube Studio ahk_exe chrome.exe"

	static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube ahk_exe chrome\.exe"

	static SkipNext() => Send("+n")

	static SkipPrev() => Send("+p")

	static MiniscreenClose() => ControlClick("X1858 Y665")

	static ClickProfile() => ControlClick("X1823 Y133")

	static WaitUntilProfileWindow() {
		this.ClickProfile()
		if !WaitUntilPixChange([1324, 116], 0x313131)
			return
	}

	static ChannelSwitch() {
		this.WaitUntilProfileWindow()
		ControlClick("x1531 y407")
	}

	static StudioSwitch() {
		this.WaitUntilProfileWindow()
		ControlClick("x1500 y376")
	}

	static ToYouTube() {
		ControlClick("x1860 y134")
		if WaitUntilPixChange([1612, 349])
			ControlClick("x1634 y350")
	}
}
