#Include <App\Browser>
#Include <App\VK>
#Include <Abstractions\Base>
#Include <Utils\Press>
#Include <Abstractions\MouseSectionDefaulter>
#Include <Tools\Info>

#HotIf WinActive(Browser.winTitle)

!1::Send("^1")
!2::Send("^2")
!3::Send("^3")
!4::Send("^4")
!5::Send("^5")
!6::Send("^6")
!7::Send("^7")
!8::Send("^8")
!9::Send("^9")
!sc33::PrevTab()
!sc34::NextTab()

!e::NewTab()
!w::CloseTab()
^p::Browser.SearchTabs()

XButton1:: {
    sections := Press.GetSections()
    MouseSectionDefaulter.Browser(sections)
}

#HotIf