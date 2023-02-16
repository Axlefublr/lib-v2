#Include <Utils\Press>
#Include <Abstractions\Base>
#Include <App\Youtube>
#Include <App\Discord>
#Include <App\Browser>
#Include <App\GitHub>
#Include <App\Telegram>
#Include <App\VK>

#MaxThreadsBuffer true

Media_Stop & XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.middle:Cut()
        ; Case WinActive(Youtube.winTitle):Youtube.StudioSwitch()
        Case WinActive(Discord.winTitle):Discord.Emoji()
    }
}

Media_Stop & XButton2:: {
    sections := Press.GetSections()
    Switch {
        Case sections.middle:WinPaste()
        Case sections.up:Send("{Browser_Forward}")
        Case sections.down:Send("{Browser_Back}")
        ; Case WinActive(Youtube.Studio):Youtube.ToYouTube()
        ; Case WinActive(Youtube.winTitle):Youtube.ChannelSwitch()
        ; Case WinActive(VK.winTitle):VK.Voice()
        Case WinActive(Telegram.winTitle):Telegram.Voice()
        Case WinActive(Discord.winTitle):Discord.Gif()
    }
}

#MaxThreadsBuffer false