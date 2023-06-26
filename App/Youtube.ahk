#Include <App\Browser>

class Youtube {

	static winTitle := "YouTube " Browser.exeTitle
	static Studio := "YouTube Studio " Browser.exeTitle

	static SkipNext() => Send("+n")

	static SkipPrev() => Send("+p")
}
