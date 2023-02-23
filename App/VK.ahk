#Include <App\Browser>
#Include <Paths>
#Include <Utils\Image>

Class VK {

    static winTitle := "Messenger " Browser.exeTitle

    static Enter() => ControlClick("x1748 y1006")

    static Scroll() {
        try VK.UIA.ScrollButton.Click()
    }

    static Reply() => WaitClick(Paths.Ptf["vk reply"])

    class UIA {

        static TopLevel {
            get => Browser.UIA.Document.FindElement({
                Type: "Group",
                Scope: 2
            })
        }

        static ChatView {
            get => VK.UIA.TopLevel.FindElement({
                ClassName: "im-page-wrapper _im-page-wrap",
                Type: "Group",
                Scope: 2
            }).FindElement({
                Type: "Group",
                ClassName: "im-page js-im-page ",
                Scope: 2
            })
        }

        static CurrentChat {
            get => VK.UIA.ChatView.FindElement({
                Type: "Group",
                Scope: 2,
                Order: 2
            })
        }

        static ChatInput {
            get => VK.UIA.CurrentChat.FindElement({
                ClassName: "im-chat-input clear_fix _im_chat_input_parent",
                Type: "Group",
                Scope: 2
            }).FindElement({
                Type: "Group",
                Scope: 2
            })
        }

        static ScrollButton {
            get => VK.UIA.CurrentChat.FindElement({
                Type: "Button",
                Scope: 2,
                Index: 2
            })
        }

        static VoiceMessageButton {
            get => VK.UIA.ChatInput.FindElement({
                Type: "Button",
                Order: 2,
                Scope: 2
            })
        }

        static SendVoiceButton {
            get => VK.UIA.CurrentChat.FindElement({
                Name: "Send",
                Type: "Button",
                Scope: 2,
                Order: 2
            })
        }

        static SendMessageButton {
            get => VK.UIA.ChatInput.FindElement({
                Type: "Button",
                Name: "Send",
                Scope: 2,
                Order: 2
            })
        }

    }

}
