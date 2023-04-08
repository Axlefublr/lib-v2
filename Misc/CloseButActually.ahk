#Include <App\VPN>
#Include <App\Spotify>
#Include <App\Steam>
#Include <App\Gimp>
#Include <App\Davinci>
#Include <App\Telegram>
#Include <App\FL>
#Include <Utils\Win>

CloseButActually() {
    Switch {
        Case WinActive(VPN.winTitle):     VPN.Close()
        Case WinActive(Spotify.exeTitle): Spotify.Close()
        Case WinActive(Steam.exeTitle):   Steam.Close()
        Case WinActive(Gimp.exeTitle):    Gimp.Close()
        Case WinActive(Davinci.winTitle): Davinci.Close()
        Case WinActive(Telegram.winTitle):Telegram.Close()
        Case WinActive(FL.exeTitle):      FL.Close()
        Default:                          Win.Close()
    }
}
