; No dependencies

class Timer {

    __New(time) {
        this.sTime := time
    }


    sTime := ""
    msTime := 0


    Start() {

    }


    _Ring() {

    }

    _GetTimeInMs() {

    }

    _ParseTimeStr() {
        arTimes := StrSplit(this.sTime, " ")
        for index, sTime in arTimes {
            this.msTime += Timer._ParseHours(sTime)
            this.msTime += Timer._ParseMinutes(sTime)
            this.msTime += Timer._ParseSeconds(sTime)
        }
    }


    static _ParseHours(sTime) {
        actualTime := StrReplace(sTime, "h")
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