#Include <Utils\Win>
#Include <Environment>
#Include <App\VPN>
#Include <Paths>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\Browser>
#Include <App\VsCode>
#Include <App\Terminal>
#Include <App\Spotify>
#Include <App\OBS>

#MaxThreadsBuffer true

#HotIf WinExist(Browser.Chat.winTitle)
<!t::Browser.Chat.winObj.MinMax()
#HotIf

<!s::Spotify.winObj.App()
<!a::VsCode.winObj.App()
<!c::Browser.winObj.App()
<!q::Discord.winObj.App()
<!t::Telegram.winObj.App()
<!r::Terminal.winObj.App()
<!z::VPN.winObj.App()

!F14::OBS.winObj.App()

#MaxThreadsBuffer false
