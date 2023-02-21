#Include <App\Terminal>
#Include <App\Spotify>
#Include <App\Discord>
#Include <App\Browser>
#Include <App\Telegram>
#Include <App\Autohotkey>
#Include <App\VsCode>
#Include <App\ClockApp>
#Include <App\VPN>

Terminal.SetupGroup()
Autohotkey.Docs.SetupGroup()

GroupAdd("Main", VsCode.winTitle)
GroupAdd("Main", Spotify.exeTitle)
GroupAdd("Main", Discord.winTitle)
GroupAdd("Main", Browser.winTitle)
GroupAdd("Main", Telegram.winTitle)
GroupAdd("Main", Terminal.winTitle)
GroupAdd("Main", Explorer.exeTitle)
GroupAdd("Main", ClockApp.winTitle)
GroupAdd("Main", VPN.winTitle)
