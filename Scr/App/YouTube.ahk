#Include <App\Youtube>
#Include <Utils\ClipSend>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.Like()
F2::i
F3::Youtube.SaveToPlaylist()
F4::Youtube.ToggleShuffle()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight
        && WinActive(Youtube.Studio): try Youtube.StudioChannelSwitch()
        Case sections.topLeft
        && WinActive(Youtube.Studio): try Youtube.ToYouTube()
        Case sections.topRight:       Youtube.ChannelSwitch()
        Case sections.topLeft:        Youtube.StudioSwitch()
        Case sections.bottomLeft:     Send("i")
        Case sections.bottomRight:    Youtube.SaveToPlaylist()
        Case sections.middle:         Youtube.Like()
        default:                      MouseSectionDefaulter.Browser(sections)
    }
}

#HotIf