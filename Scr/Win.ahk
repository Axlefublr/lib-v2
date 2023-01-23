#Include <Utils\Win>
#Include <App\VPN>
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

<!Escape::GroupDeactivate("Main")
<+Escape::Win.Minimize()

<!s::Spotify.winObj.App()
<!a::VsCode.winObj.App()
<!c::Browser.winObj.App()
<!q::Discord.winObj.App()
<!t::Telegram.winObj.App()
<!r::Terminal.winObj.App()
<!x::Autohotkey.Docs.v2.winObj.App()
<!z::OBS.winObj.App()
<!f::VPN.winObj.App()

<!d:: {
   key := KeyChorder()
   static keyActions := Map(

      "q", () => Explorer.WinObj.Volume.App_Folders(),
      "v", () => Explorer.WinObj.Pictures.App_Folders(),
      "t", () => Explorer.WinObj.VideoTools.App_Folders(),
      "s", () => Explorer.WinObj.Memes.App_Folders(),
      "e", () => Explorer.WinObj.Emoji.App_Folders(),
      "a", () => Explorer.WinObj.Audio.App_Folders(),
      "w", () => Explorer.WinObj.ScreenVideos.App_Folders(),
      "d", () => (SetTitleMatchMode("RegEx"), Explorer.WinObj.PC.App()),

   )

   try keyActions[key].Call()
}


#MaxThreadsBuffer false
