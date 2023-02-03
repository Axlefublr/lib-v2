#Include <App\VsCode>
#Include <App\Browser>
#Include <App\Spotify>
#Include <App\Discord>
#Include <App\Terminal>

MainApps() {
    Discord.winObj.RunAct()
    VsCode.winObj.RunAct()
    Terminal.winObj.RunAct()
    Browser.winObj.RunAct()
    Spotify.winObj.RunAct()
}
