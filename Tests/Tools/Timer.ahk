#Include <Tests\Testable>
#Include <Tests\ErrorObjects>
#Include <Tools\Timer>

class TimerTests extends Testable {

    static __New() {
        TimerTests().RunAll()
    }


    _ParseHours() {

        input := "h2h"
        expected := 7200000

        actual := Timer._ParseHours(input)
        if actual != expected
            throw InputExpectedActualError("_ParseHours", input, expected, actual)
    }

    _ParseMinutes() {

        input := "m2m"
        expected := 120000

        actual := Timer._ParseMinutes(input)
        if actual != expected
            throw InputExpectedActualError("_ParseMinutes", input, expected, actual)
    }

    _ParseSeconds() {

        input := "s2s"
        expected := 2000

        actual := Timer._ParseSeconds(input)
        if actual != expected
            throw InputExpectedActualError("_ParseSeconds", input, expected, actual)
    }

    _ParseTimeStr() {

        input := "h2h m2mm s2ss"
        expected := 7322000

        actual := Timer(input)._ParseTimeStr().msTime
        if actual != expected
            throw InputExpectedActualError("_ParseTimeStr", input, expected, actual)
    }

}