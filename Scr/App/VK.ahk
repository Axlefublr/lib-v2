#Include <Utils\Press>
#Include <App\VK>
#Include <Abstractions\MouseSectionDefaulter>

#HotIf WinActive(VK.winTitle)
MButton::VK.Reply()
^Enter::VK.Enter()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight: VK.Enter()
        Case sections.down:     VK.Scroll()
        default:                MouseSectionDefaulter.Browser(sections)
    }
}

#HotIf