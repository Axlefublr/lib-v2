#Include <Utils\Image>
#Include <App\Browser>
#Include <Misc\HandleUIAError>

Class Youtube {

    static winTitle := "YouTube " Browser.exeTitle

    static Studio := "YouTube Studio " Browser.exeTitle

    static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube " Browser.exeTitle

    static SkipNext() => Send("+n")

    static SkipPrev() => Send("+p")

    static ToggleMiniscreen() => Send("i")

}
