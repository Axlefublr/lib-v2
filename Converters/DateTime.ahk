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

	/**
	 * Convert a YYYYMMDDHH24MISS timestamp into the amount of seconds it is.
	 * This is useful for specifying the amount of time to pass in the format of the timestamp, rather than having to do math.
	 * Years and months are calculated by averages.
	 * @param timeStamp *YYYYMMDDHH24MISS*
	 * @returns {Integer}
	 */
	static ConvertToSeconds(timeStamp) {
		timeObj := this.ParseTimestamp(timeStamp)

		yearsInSec   := timeObj.years * DateTime.DaysInAYear * DateTime.SecondsInADay
		monthsInSec  := timeObj.months * DateTime.DaysInAMonth * DateTime.SecondsInADay
		daysInSec    := timeObj.days * DateTime.SecondsInADay
		hoursInSec   := timeObj.hours * DateTime.SecondsInAnHour
		minutesInSec := timeObj.minutes * 60

		return yearsInSec + monthsInSec + daysInSec + hoursInSec + minutesInSec + timeObj.seconds
	}

	/**
	 * Add a timestamp to a timestamp.
	 * @param base *YYYYMMDDHH24MISS*
	 * @param toAdd *YYYYMMDDHH24MISS*
	 * @returns {YYYYMMDDHH24MISS}
	 */
	static AddTimestamp(base, toAdd) {
		base := this.CorrectTimestamp(base)
		toAddObj := this.ParseTimestamp(toAdd)
		base := DateAdd(base, toAddObj.seconds, "seconds")
		base := DateAdd(base, toAddObj.minutes, "minutes")
		base := DateAdd(base, toAddObj.hours, "hours")
		base := DateAdd(base, toAddObj.days, "days")
		base := this.AddMonths(base, toAddObj.months)
		base := this.AddYears(base, toAddObj.years)
		return base
	}

	/**
	 * DateAdd doesn't let you add months, for some reason.
	 * Use this instead.
	 * If you want to subtract instead of adding, just pass a negative number.
	 * @param {YYYYMMDDHH24MISS} dateTime
	 * @param {Integer} addMonths
	 * @returns {YYYYMMDDHH24MISS}
	 */
	static AddMonths(dateTime, addMonths) {
		dateTime := this.ParseTimestamp(dateTime)

		years  := dateTime.years
		months := dateTime.months
		rest   := dateTime.days dateTime.hours dateTime.minutes dateTime.seconds

		months += addMonths

		if months > 12 {
			years += months // 12
			months := Mod(months, 12)
		}

		if months < 1 {
			years--
			months := 12 - Abs(months)
		}

		if StrLen(months) < 2
			months := 0 months

		return years months rest
	}

	/**
	 * DateAdd doesn't let you add years, for some reason.
	 * Use this.
	 * If you want to subtract instead of adding, just pass a negative number.
	 * @param {YYYYMMDDHH24MISS} dateTime
	 * @param {Integer} addYears
	 * @returns {YYYYMMDDHH24MISS}
	 */
	static AddYears(dateTime, addYears) {
		dateTime := this.ParseTimestamp(dateTime)

		years  := dateTime.years
		rest := dateTime.months dateTime.days dateTime.hours dateTime.minutes dateTime.seconds

		years += addYears

		return years rest
	}

}