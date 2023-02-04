#Include <Paths>
#Include <Utils\Eval>
#Include <Abstractions\Text>
#Include <Extensions\Json>
#Include <Tools\Info>

Class Timer {

    /**
     * The json file path that timer writes and reads from
     * @type {String}
     */
    static jsonPath := Paths.Ptf["Timer.json"]

    static RestartTimers() {
        jsonObj := JSON.parse(ReadFile(this.jsonPath))
        timersToRenew := []

        for key, value in jsonObj {
            jsonObj.Delete(key)

            if value < A_Now
                continue

            seconds := DateDiff(value, A_Now, "seconds")
            timersToRenew.Push(Timer(seconds))
        }
        WriteFile(this.jsonPath, JSON.stringify(jsonObj))

        for index, timerObj in timersToRenew {
            timerObj.Start()
        }
    }

    shouldRing := true

    __New(seconds) {

        seconds := eval(seconds)
        this.endTime := DateAdd(A_Now, seconds, "seconds")
        this.duration := seconds
        this.hash := String(Random(1, 100000))

    }

    __WriteJson() {
        jsonObj := JSON.parse(ReadFile(Timer.jsonPath))
        jsonObj.Set(this.hash, this.endTime)
        WriteFile(Timer.jsonPath, JSON.stringify(jsonObj))
    }

    __DeleteJson() {
        jsonObj := JSON.parse(ReadFile(Timer.jsonPath))
        jsonObj.Delete(this.hash)
        WriteFile(Timer.jsonPath, JSON.stringify(jsonObj))
    }

    Start() {
        this.__WriteJson()
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
        this.__DeleteJson()
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
    StopSound() => (Send("{Media_Stop}"), this.__DeleteJson())
}