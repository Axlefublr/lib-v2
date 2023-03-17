#Include <Tools\Info>
#Include <Paths>

class Timer {

    __New(time) {
        this.sTime := time
        this._ParseTimeStr()
    }


    sTime := ""
    msTime := 0


    Start() {
        SetTimer(this._foRing, -this.msTime)
        Info("Timer started!", 500)
    }


    _foRing := this._Ring.Bind(this)
    _Ring() {
        Infos("Timer for " this.sTime " is done!")
        loop 2
            SoundPlay(Paths.Ptf["ting"])
    }

    _ParseTimeStr() {
        arTimes := StrSplit(this.sTime, " ")
        for index, sTime in arTimes {
            this.msTime += Timer._ParseHours(sTime)
            this.msTime += Timer._ParseMinutes(sTime)
            this.msTime += Timer._ParseSeconds(sTime)
        }
        return this
    }


    static _ParseHours(sTime) {
        Infos(sTime)
        actualTime := StrReplace(sTime, "h")
        Infos(actualTime)
        if sTime != actualTime
            return actualTime * 60 * 60 * 1000
        return 0
    }

    static _ParseMinutes(sTime) {
        actualTime := StrReplace(sTime, "m")
        if sTime != actualTime
            return actualTime * 60 * 1000
        return 0
    }

    static _ParseSeconds(sTime) {
        actualTime := StrReplace(sTime, "s")
        if sTime != actualTime
            return actualTime * 1000
        return 0
    }
}