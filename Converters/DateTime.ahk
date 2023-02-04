; No dependencies

class DateTime {

    static Date {
        get => FormatTime(, "yy.MM.dd")
    }

    static Time {
        get => FormatTime(, "HH:mm")
    }

    static WeekDay {
        get => FormatTime(, "dddd")
    }

    /**
     * 365.24
     * @type {Float}
     */
    static DaysInAYear := 365.24

    /**
     * 30.43(6)
     * @type {Float}
     */
    static DaysInAMonth := this.DaysInAYear / 12

    /**
     * 86400
     * @type {Integer}
     */
    static SecondsInADay := 86400

    /**
     * 3600
     * @type {Integer}
     */
    static SecondsInAnHour := 3600

    /**
     * YYYY - 4
     * MM - 2
     * DD - 2
     * HH - 2
     * 24 - just means there's no AM/PM
     * MI - 2
     * SS - 2
     * 14 characters total in the YYYYMMDDHH24MISS timestamp
     * @type {Integer}
     */
    static StandardTimestampLength := 14 ;naming suggestion by @DepthTrawler

    /**
     * If you use "1" as a timestamp, it will mean "1000 years".
     * You would probably expect "1" to be "1 second".
     * This method converts your timestamp to match this expectation.
     * @param timestamp *Integer* A number you intend to use as a YYYYMMDDHH24MISS timestamp
     * @returns {Integer} A correctly formatted YYYYMMDDHH24MISS timestamp
     */
    static CorrectTimestamp(timestamp) {
        while StrLen(timestamp) < DateTime.StandardTimestampLength {
            timestamp := 0 timestamp
        }
        return timestamp
    }

    /**
     * The YYYYMMDDHH24MISS timestamp is really annoying to work with,
     * use this method to convert it to an object.
     * The time in properties will have leading zeros if necessary.
     * @param timeStamp *YYYYMMDDHH24MISS* timestamp.
     * Accepts an incomplete one, where "10000" would mean 1 hour:
     * the leading zeros required for a correct timestamp are added automatically.
     * @returns {Object} Available properties: years, months, days, hours, minutes, seconds.
     */
    static ParseTimestamp(timeStamp := A_Now) {
        timeStamp := this.CorrectTimestamp(timeStamp) ;if there are no leading zeros in the timestamp, "10000" would be considered "the year 1000" rather than "1 hour"

        years   := SubStr(timeStamp, 1,  4)
        months  := SubStr(timeStamp, 5,  2)
        days    := SubStr(timeStamp, 7,  2)
        hours   := SubStr(timeStamp, 9,  2)
        minutes := SubStr(timeStamp, 11, 2)
        seconds := SubStr(timeStamp, 13, 2)

        if timeStamp < 0 {
            years   := -years
            months  := -months
            days    := -months
            hours   := -hours
            minutes := -minutes
            seconds := -seconds
        }

        return {
            years:   years,
            months:  months,
            days:    days,
            hours:   hours,
            minutes: minutes,
            seconds: seconds
        }
    }
}