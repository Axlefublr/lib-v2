#Include <Utils\Image>
#Include <App\Browser>

Class Youtube {

    static winTitle := "YouTube " Browser.exeTitle

    static Studio := "YouTube Studio " Browser.exeTitle

    static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube " Browser.exeTitle

    static SkipNext() => Send("+n")

    static SkipPrev() => Send("+p")

    static ClickProfile() => ControlClick("x1819 y155")

    static WaitUntilProfileWindow() {
        Browser.ClickProfile()
        if !WaitUntilPixChange([1538, 503])
            return
    }

    static ChannelSwitch() {
        Browser.WaitUntilProfileWindow()
        ControlClick("x1531 y407")
    }

    static StudioSwitch() {
        Browser.WaitUntilProfileWindow()
        ControlClick("x1500 y376")
    }

    static ToYouTube() {
        ControlClick("x1860 y134")
        if WaitUntilPixChange([1612, 349])
            ControlClick("x1634 y350")
    }
}
