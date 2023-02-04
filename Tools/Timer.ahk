#Include <Tools\Info>

Class Timer {

    __New(minutes) {
        this.minutes := minutes
        this.duration := minutes * 60 * 1000
    }

    Start() {
        action := this.Alarm.Bind(this)
        SetTimer(action, -this.duration)
        Info("Timer set for " this.minutes " minutes")
    }

    /**
     * The ringer. Will show you an Infos that displays the time you set that timer for
     * Will continue to beep intermittently until you close the info (press escape or click on the info)
     * @private
     */
    Alarm() {
        infoHwnd := Infos("Your timer for " this.minutes " minutes is up!").gInfo.Hwnd
        while WinExist(infoHwnd) {
            SoundBeep()
            Sleep(200)
        }
    }

}