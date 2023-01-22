#Include <App\VsCode>
#Include <App\Telegram>
#Include <App\Browser>
#Include <App\Spotify>
#Include <App\Discord>

MainApps() {
   VsCode.winObj.RunAct()
   Terminal.winObj.RunAct()
   Browser.winObj.RunAct()
   Spotify.winObj.RunAct()
   Discord.winObj.RunAct()
}
