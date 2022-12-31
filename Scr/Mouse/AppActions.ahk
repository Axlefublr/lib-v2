#Include <Press>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\Terminal>
#Include <App\Explorer>
#Include <App\VsCode>
#Include <App\Spotify>
#Include <App\Browser>
#Include <App\VK>
#Include <Win>
#Include <Base>
#Include <Script>

#MaxThreadsBuffer true

Media_Stop:: {
   sections := GetSections()
   Switch {
      Case sections.topRight:    GroupDeactivate("Main")
      Case sections.bottomRight: Telegram.winObj.App()
      Case sections.right:       Discord.winObj.App()
      Case sections.topLeft:     Terminal.winObj.App()
      Case sections.bottomLeft:
         SetTitleMatchMode("Regex")
         Explorer.winObjRegex.MinMax()
      Case sections.left:        VsCode.winObj.App()
      Case sections.down:        Spotify.winObj.App()
      Case sections.up:          Browser.winObj.App()
      Default:                   AltTab()
   }
}

XButton1:: {
   sections := GetSections()
   Switch {
      Case sections.middle:Copy()
      Case WinActive(Browser.winTitle):
         Switch {
            Case sections.right:         NextTab()
            Case sections.left:          PrevTab()
            Case sections.up:            RestoreTab()
            Case WinActive(VK.winTitle): VK.Scroll()
            Case sections.down:          CloseTab()
         }
      Case WinActive(VsCode.winTitle) || WinActive(Terminal.winTitle):
         Switch {
            Case sections.bottomRight:scr_Reload()
            Case sections.right:      NextTab()
            Case sections.bottomLeft: scr_Test()
            Case sections.left:       PrevTab()
            Case sections.down:       VsCode.CloseTab()
            Case sections.up:         RestoreTab()
         }
      Case WinActive(Spotify.exeTitle):
         Switch {
            Case sections.topRight:   Spotify.NewDiscovery()
            Case sections.bottomRight:Spotify.Discovery()
            Case sections.topLeft:    Spotify.Context()
            Case sections.bottomLeft: Spotify.FavRapper_Auto()
            Case sections.up:         Spotify.Like()
            Case sections.down:       Spotify.Shuffle()
         }
      Case WinActive(Telegram.winTitle) && sections.down:Telegram.Scroll()
      Case WinActive(Discord.winTitle)  && sections.down:Send("{Esc}")
   }
}

#MaxThreadsBuffer false