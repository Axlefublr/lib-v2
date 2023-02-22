#Include <App\Youtube>
#Include <Utils\ClipSend>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>

#HotIf WinActive(Youtube.winTitle)
F1::try Youtube.Like()

PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight
        && WinActive(Youtube.Studio): try Youtube.StudioChannelSwitch()
        Case sections.topLeft
        && WinActive(Youtube.Studio): try Youtube.ToYouTube()
        Case sections.topRight:       try Youtube.ChannelSwitch()
        Case sections.topLeft:        try Youtube.StudioSwitch()
        Case sections.middle:         try Youtube.Like()
        Case sections.right:          NextTab()
        Case sections.left:           PrevTab()
        Case sections.up:             RestoreTab()
        Case sections.down:           CloseTab()
    }
}
#HotIf