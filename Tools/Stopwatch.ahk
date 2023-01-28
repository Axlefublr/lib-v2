#Include <Converters\DateTime>

/**
 * A stopwatch, accurate to the seconds
 * Time calculation only happens once you get CurrTime,
 * so there's no Stop method
 * There's also no need because you do a restart via using Start()
 * There's a static way to use this class, since you will most likely 
 * have hotkeys for starting the stopwatch and getting its current time,
 * and storing a class object can be annoying when you don't plan on
 * having multiple stopwatches at the same time
 */
class Stopwatch {

    /**
     * The time your stopwatch started at
     * In YYYYMMDDHH24MISS format
     * @type {Integer}
     */
    startingTime := unset

    /**
     * Start the stopwatch
     * @returns {Integer} The startingTime property
     */
    Start() => this.startingTime := A_Now

    /**
     * The time passed after the start of the stopwatch
     * @type {String} time in format HH:mm:ss
     */
    CurrTime {
        get => FormatTime(DateTime.CorrectTimestamp(A_Now - this.startingTime), "HH:mm:ss")
    }

    /**
     * The time your stopwatch started at
     * In YYYYMMDDHH24MISS format
     * @type {Integer}
     */
    static startingTime := 0

    /**
     * Start the stopwatch by setting the startingTime property
     * @returns {Integer} The startingTime property
     */
    static Start() => this.startingTime := A_Now

    /**
     * The time passed after the start of the stopwatch
     * @type {String} time in format HH:mm:ss
     */
    static CurrTime {
        get => FormatTime(DateTime.CorrectTimestamp(A_Now - this.startingTime), "HH:mm:ss")
    }
}
