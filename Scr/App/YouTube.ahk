#Include <App\Youtube>
#Include <Utils\ClipSend>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.Like()

PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight
        && WinActive(Youtube.Studio): Youtube.StudioChannelSwitch()
        Case sections.topLeft
        && WinActive(Youtube.Studio): Youtube.ToYouTube()
        Case sections.topRight:       Youtube.ChannelSwitch()
        Case sections.topLeft:        Youtube.StudioSwitch()
        Case sections.middle:         Youtube.Like()
        Case sections.right:          NextTab()
        Case sections.left:           PrevTab()
        Case sections.up:             RestoreTab()
        Case sections.down:           CloseTab()
    }
}
#HotIf