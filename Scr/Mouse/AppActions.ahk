#Include <Utils\Press>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\Terminal>
#Include <App\Explorer>
#Include <App\VsCode>
#Include <App\Spotify>
#Include <App\Browser>
#Include <Utils\Win>
#Include <Abstractions\Base>

#MaxThreadsBuffer true

Media_Stop:: {
	sections := Press.GetSections()
	Switch {
		Case sections.topRight:    GroupDeactivate("Main")
		Case sections.bottomRight: Telegram.winObj.App()
		Case sections.right:       Discord.winObj.App()
		Case sections.topLeft:     Terminal.winObj.App()
		Case sections.bottomLeft:  Explorer.winObj.MinMax()
		Case sections.left:        VsCode.winObj.App()
		Case sections.down:        Spotify.winObj.App()
		Case sections.up:          Browser.winObj.App()
		Default:                   AltTab()
	}
}

#MaxThreadsBuffer false