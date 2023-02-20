#Include <Utils\Image>
#Include <App\Browser>

Class Youtube {

    static winTitle := "YouTube " Browser.exeTitle

    static Studio := "YouTube Studio " Browser.exeTitle

    static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube " Browser.exeTitle

    static SkipNext() => Send("+n")

    static SkipPrev() => Send("+p")

    static ClickProfile() => Youtube.UIA.AccountElement.Click()

    static StudioClickProfile() => Youtube.UIA.StudioAccountElement.Click()

    static WaitUntilProfileWindow() {
        Youtube.ClickProfile()
        if !WaitUntilPixChange([1520, 136])
            return
    }

    static ChannelSwitch() {
        Youtube.WaitUntilProfileWindow()
        Youtube.UIA.SwitchAccountElement.Click()
    }

    static StudioChannelSwitch() {
        Youtube.StudioClickProfile()
        Youtube.UIA.StudioSwitchAccountElement.Click()
    }

    static StudioSwitch() {
        Youtube.WaitUntilProfileWindow()
        Youtube.UIA.YoutubeStudioElement.Click()
    }

    static ToYouTube() {
        Youtube.StudioClickProfile()
        Youtube.UIA.StudioToYoutubeElement.Click()
    }

    static Like() => Youtube.UIA.LikeButtonElement.ToggleState := true

    class UIA {

        static MainGroup {
            get => Browser.UIA.Document.FindElement({
                Type: "Group"
            }).FindElement({
                Type: "Group",
                Scope: 2
            })
        }

        static MainElement {
            get => Youtube.UIA.MainGroup.FindElement({
                LocalizedType: "main",
                Scope: 2
            })
        }

        static LikeButtonElement {
            get => Youtube.UIA.MainElement.FindElement({
                Type: "Group",
                ClassName: "style-scope ytd-segmented-like-dislike-button-renderer",
                Scope: 2
            }).FindElement({
                LocalizedType: "toggle button",
                Scope: 2
            })
        }

        static BannerElement {
            get => Browser.UIA.Document.FindElement({
                ; Type: "Group",
                LocalizedType: "banner",
                ; AutomationId: "masthead",
                Scope: 2
            })
        }

        static AccountElement {
            get => Youtube.UIA.BannerElement.FindElement({
                Type: "MenuItem",
                Name: "Account profile photo that opens list of alternate accounts",
                AutomationId: "avatar-btn",
                Scope: 2
            })
        }

        static StudioAccountElement {
            get => Youtube.UIA.BannerElement.FindElement({
                Name: "Account",
                Order: 2,
                Scope: 2
            })
        }

        static AccountFloatingMenuElement {
            get => Browser.UIA.Document.WaitElement({
                AutomationId: "container",
                ; Type: 50025,
                Order: 2
            })
        }

        static StudioAccountFloatingMenuElement {
            get => Browser.UIA.Document.WaitElement({
                Type: 50025,
                Order: 2,
                Scope: 2,
                Index: -2
            })
        }

        static StudioToYoutubeElement {
            get => Browser.UIA.Document.WaitElement({
                Name: "YouTube",
                Type: "Link",
                Order: 2
            })
        }

        static SwitchAccountElement {
            get => Youtube.UIA.AccountFloatingMenuElement.WaitElement({
                Name: "Switch account",
                Scope: 2
            })
        }

        static StudioSwitchAccountElement {
            get => Browser.UIA.Document.WaitElement({
                Type: "Link",
                Name: "Switch account",
                Order: 2
            })
        }

        static YoutubeStudioElement {
            get => Youtube.UIA.AccountFloatingMenuElement.WaitElement({
                Name: "YouTube Studio",
                Scope: 2
            })
        }
    }
}
