; No dependencies

MeasureExecutionInSeconds(delegate) {
    DllCall("GetSystemTimePreciseAsFileTime", "Int64P", &Start := 0)
    delegate()
    DllCall("GetSystemTimePreciseAsFileTime", "Int64P", &End := 0)
    return Round((End - Start) / 10000000, 7)
}