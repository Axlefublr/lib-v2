class Brightness {

	static __comObjPath := "winmgmts:\\.\root\WMI"

	static ChangeBrightnessAbsolute(brightness) {
		switch {
			case brightness < 0:brightness := 0
			case brightness > 100:brightness := 100
		}
		for property in ComObjGet(this.__comObjPath).ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods")
			property.WmiSetBrightness(1, brightness)
	}

	static ChangeBrightnessRelative(difference) => this.ChangeBrightnessAbsolute(this.GetCurrBrightness() + difference)

	static GetCurrBrightness() {
		for property in ComObjGet(this.__comObjPath).ExecQuery("SELECT * FROM WmiMonitorBrightness")
			currentBrightness := property.CurrentBrightness
		return currentBrightness
	}
}