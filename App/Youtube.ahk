#Include <Utils\Image>
#Include <App\Browser>

Class Youtube {

    static winTitle := "YouTube " Browser.exeTitle

    static Studio := "YouTube Studio " Browser.exeTitle

    static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube " Browser.exeTitle

    static SkipNext() => Send("+n")

    static SkipPrev() => Send("+p")

    static ChannelSwitch() {
        Youtube.UIA.AccountElement.Click()
        Youtube.UIA.SwitchAccountElement.Click()
    }

    static StudioChannelSwitch() {
        Youtube.UIA.StudioAccountElement.Click()
        Youtube.UIA.StudioSwitchAccountElement.Click()
    }

    static StudioSwitch() {
        Youtube.UIA.AccountElement.Click()
        Youtube.UIA.YoutubeStudioElement.Click()
    }

    static ToYouTube() {
        Youtube.UIA.StudioAccountElement.Click()
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
            get => Youtube.UIA.MainGroup.FindElement({
                LocalizedType: "banner",
                Scope: 2
            })
        }

        static AccountElement {
            get => Youtube.UIA.BannerElement.FindElement({
                Type: "Button",
                Name: "Account profile photo that opens list of alternate accounts",
                AutomationId: "avatar-btn",
                Order: 2
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
            get => Youtube.UIA.MainGroup.WaitElement({
                Type: "Group",
                Name: "Manage your Google Account Your channel YouTube Studio Switch account",
                Matchmode: "Substring",
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
                Type: "Link",
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
                Type: "Link",
                Name: "YouTube Studio",
            })
        }
    }
}
