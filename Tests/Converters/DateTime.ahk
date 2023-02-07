#Include <Converters\DateTime>

class DateTimeTests {

    static __New() {
        this.AddMonths_AddLessThanYear_GetLessThanYear()
        this.AddMonths_SubLessThanYear_GetLessThanYear()
        this.AddMonths_AddLessThanYear_GetMoreThanYear()
        this.AddMonths_SubLessThanYear_GetMoreThanYear()
        this.AddMonths_AddYear()
        this.AddMonths_SubYear()
        this.AddMonths_AddMoreThanYear()
        this.AddMonths_SubMoreThanYear()
    }

    static AddMonths_AddLessThanYear_GetLessThanYear() {

        startDate := 20230211223344
        endDate   := 20230711223344

        actual := DateTime.AddMonths(startDate, 5)
        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_SubLessThanYear_GetLessThanYear() {

        startDate := 20230511223344
        endDate   := 20230211223344

        actual := DateTime.AddMonths(startDate, -3)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)

    }

    static AddMonths_AddLessThanYear_GetMoreThanYear() {

        startDate := 20230711223344
        endDate   := 20240111223344

        actual := DateTime.AddMonths(startDate, 6)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_SubLessThanYear_GetMoreThanYear() {

        startDate := 20230211223344
        endDate   := 20221211223344

        actual := DateTime.AddMonths(startDate, -2)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_AddYear() {

        startDate := 20230211223344
        endDate   := 20240211223344

        actual := DateTime.AddMonths(startDate, 12)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_SubYear() {

        startDate := 20230211223344
        endDate   := 20220211223344

        actual := DateTime.AddMonths(startDate, -12)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_AddMoreThanYear() {

        startDate := 20230211223344
        endDate   := 20240311223344

        actual := DateTime.AddMonths(startDate, 13)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

    static AddMonths_SubMoreThanYear() {

        startDate := 20230211223344
        endDate   := 20220111223344

        actual := DateTime.AddMonths(startDate, -13)

        if actual != endDate
            throw ValueError("Expected: " endDate, -1, actual)
    }

}