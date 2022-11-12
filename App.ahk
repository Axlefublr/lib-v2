#Include <Press>
#Include <Base>
#Include <Global>
#Include <Win>
#Include <ClipSend>
#Include <Paths>
#Include <String>
#Include <String-full>
#Include <Info>
#Include <Json>
#Include <Sort>
#Include <Get>
#Include <Text>
#Include <Image>
#Include <Cmd>

#Include <App\Browser>
#Include <App\Spotify>
#Include <App\VK>
#Include <App\Youtube>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\VsCode>
#Include <App\Terminal>
#Include <App\Git>
#Include <App\GitHub>
#Include <App\Shows>
#Include <App\Video>
#Include <App\Explorer>
#Include <App\Davinci>

Class Screenshot {
   static winTitle := "Screen Snipping ahk_exe ScreenClippingHost.exe"
   
   static Start() => Send("#+s")

   static FullScreenOut() {
      this.Start()
      WinWaitActive(this.winTitle)
      this.Fullscreen()
   }

   static Rectangle()  => ClickThenGoBack("839 6")
   static Window()     => ClickThenGoBack("959 6")
   static Fullscreen() => ClickThenGoBack("1018 31")
}