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

Media_Stop:: {
	sections := Press.GetSections()
	switch {
		case sections.topRight:    GroupDeactivate("Main")
		case sections.bottomRight
			&& WinExist(Browser.Chat.winTitle): Browser.Chat.winObj.MinMax()
		case sections.bottomRight: Telegram.winObj.App()
		case sections.right:       Discord.winObj.App()
		case sections.topLeft:     Terminal.winObj.App()
		case sections.bottomLeft:  Explorer.winObj.MinMax()
		case sections.left:        VsCode.winObj.App()
		case sections.down:        Spotify.winObj.App()
		case sections.up:          Browser.winObj.App()
		default:                   AltTab()
	}
}