#Include <App\Youtube>
#Include <Utils\ClipSend>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(Youtube.winTitle)
F1::Youtube.ToggleMiniscreen()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.bottomLeft: Youtube.ToggleMiniscreen()
        default:                  MouseSectionDefaulter.Browser(sections)
    }
}

#HotIf