#Include <Utils\Win>
#Include <Abstractions\Global>
#Include <Loaders\Links>
#Include <Tools\Info>
#Include <Utils\Press>
#Include <Paths>
#Include <App\OBS>
#Include <App\Explorer>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\Browser>
#Include <App\Autohotkey>
#Include <App\VsCode>
#Include <App\Terminal>
#Include <App\Spotify>

#MaxThreadsBuffer true

#m::RunLink(Links["gmail"])
#sc33::RunLink(Links["ghm"])

#n::Browser.MonkeyType.winObj.App()

<!s::Spotify.winObj.App()
<!a::VsCode.winObj.App()
<!c::Browser.winObj.App()
<!q::Discord.winObj.App()
<!t::Telegram.winObj.App()
<!r::Terminal.winObj.App()
<!x::Autohotkey.Docs.v2.winObj.App()

<!z::OBS.winObj.App()

<!d::Explorer.WinObj.Volume.App_Folders()
<!v::Explorer.WinObj.Pictures.App_Folders()

<!Escape::GroupDeactivate("Main")
<+Escape:: {
   SetTitleMatchMode("Regex")
   Explorer.winObjRegex.MinMax()
}

#MaxThreadsBuffer false
