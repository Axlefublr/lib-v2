#Include <Tests\Testable>
#Include <Tests\ErrorObjects>
#Include <Converters\DateTime>

class DateTimeTests extends Testable {

	static __New() {
		DateTimeTests().RunAll()
	}

	AddMonths_AddLessThanYear_GetLessThanYear() {

		input    := 20230211223344
		expected := 20230711223344

		actual := DateTime.AddMonths(input, 5)
		if actual != expected
			throw InputExpectedActualError("AddMonths_AddLessThanYear_GetLessThanYear", input, expected, actual)
	}

	AddMonths_SubLessThanYear_GetLessThanYear() {

		input    := 20230511223344
		expected := 20230211223344

		actual := DateTime.AddMonths(input, -3)

		if actual != expected
			throw InputExpectedActualError("AddMonths_SubLessThanYear_GetLessThanYear", input, expected, actual)

	}

	AddMonths_AddLessThanYear_GetMoreThanYear() {

		input    := 20230711223344
		expected := 20240111223344

		actual := DateTime.AddMonths(input, 6)

		if actual != expected
			throw InputExpectedActualError("AddMonths_AddLessThanYear_GetMoreThanYear", input, expected, actual)
	}

	AddMonths_SubLessThanYear_GetMoreThanYear() {

		input    := 20230211223344
		expected := 20221211223344

		actual := DateTime.AddMonths(input, -2)

		if actual != expected
			throw InputExpectedActualError("AddMonths_SubLessThanYear_GetMoreThanYear", input, expected, actual)
	}

	AddMonths_AddYear() {

		input    := 20230211223344
		expected := 20240211223344

		actual := DateTime.AddMonths(input, 12)

		if actual != expected
			throw InputExpectedActualError("AddMonths_AddYear", input, expected, actual)
	}

	AddMonths_SubYear() {

		input    := 20230211223344
		expected := 20220211223344

		actual := DateTime.AddMonths(input, -12)

		if actual != expected
			throw InputExpectedActualError("AddMonths_SubYear", input, expected, actual)
	}

	AddMonths_AddMoreThanYear() {

		input    := 20230211223344
		expected := 20240311223344

		actual := DateTime.AddMonths(input, 13)

		if actual != expected
			throw InputExpectedActualError("AddMonths_AddMoreThanYear", input, expected, actual)
	}

	AddMonths_SubMoreThanYear() {

		input    := 20230211223344
		expected := 20220111223344

		actual := DateTime.AddMonths(input, -13)

		if actual != expected
			throw InputExpectedActualError("AddMonths_SubMoreThanYear", input, expected, actual)
	}

	AddYears_Add() {

		input    := 20231122334455
		expected := 20251122334455

		actual := DateTime.AddYears(input, 2)

		if actual != expected
			throw InputExpectedActualError("AddYears_Add", input, expected, actual)
	}

	AddYears_Sub() {

		input    := 20231122334455
		expected := 20201122334455

		actual := DateTime.AddYears(input, -3)

		if actual != expected
			throw InputExpectedActualError("AddYears_Sub", input, expected, actual)
	}

}
