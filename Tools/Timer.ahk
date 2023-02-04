#Include <Paths>
#Include <Abstractions\Text>
#Include <Extensions\Json>
#Include <Tools\Info>

Class Timer {

    static jsonPath := Paths.Ptf["Timer.json"]

    shouldRing := true

    __New(seconds) {

        seconds := eval(seconds)
        this.endTime := DateAdd(A_Now, seconds, "seconds")
        this.duration := seconds

    }

    Start() {
        if this.shouldRing {
            action := this.Alarm.Bind(this)
        } else {
            action := this.StopSound.Bind(this)
        }

        SetTimer(action, -this.duration * 1000)
        Info("Timer set for " this.duration)
    }

    /**
     * The ringer. Will show you an Infos that displays the time you set that timer for
     * Will continue to beep intermittently until you close the info (press escape or click on the info)
     * @private
     */
    Alarm() {
        infoHwnd := Infos("Your timer for " this.duration " is up!").gInfo.Hwnd
        while WinExist(infoHwnd) {
            SoundBeep()
            Sleep(200)
        }
    }

    /**
     * An alternative to the usual beeping ringer, that will instead just disable your music
     * You can get this behavior if you set the "shouldRing" property to false
     * @private
     */
    StopSound() => Send("{Media_Stop}")
}