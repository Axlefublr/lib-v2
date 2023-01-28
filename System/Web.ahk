; No dependencies

GetHtml(link) {
    HTTP := ComObject("WinHttp.WinHttpRequest.5.1")
    HTTP.Open("GET", link, true)
    HTTP.Send()
    try HTTP.WaitForResponse()
    catch Any {
        return ""
    }
    return HTTP.ResponseText
}
