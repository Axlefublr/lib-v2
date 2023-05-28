#Include <Notes\Vim>
#Include <Notes\Long>
#Include <Notes\Git>
#Include <Notes\Math>
#Include <Links\Github>
#Include <Links\DiscordPins>
#Include <Links\General>
#Include <Links\Channel>
#Include <Links\Memes>
#Include <Links\Tools>
#Include <Links\Docs>
#Include <Links\AhkLib>
#Include <Links\Fonts>
#Include <Notes\Code>
#Include <Notes\Info>
#Include <Notes\Tech>
#Include <Notes\Terminal>
#Include <Extensions\Map>
#Include <Tools\StateBulb>

class Environment {

	static Notes := this._GenerateNotesMap()
	static Links := this._GenerateLinksMap()

	static _vimMode := false
	static VimMode {
		get => this._vimMode
		set {
			this._vimMode := value
			if value
				StateBulb[1].Create()
			else {
				StateBulb[1].Destroy()
				this.WindowManagerMode := value
			}
		}
	}

	static _windowManagerMode := false
	static WindowManagerMode {
		get => this._windowManagerMode
		set {
			this._windowManagerMode := value
			if value
				StateBulb[5].Create()
			else
				StateBulb[5].Destroy()
		}
	}


	static _GenerateNotesMap() {
		Notes := Map()
		Notes.Set(Notes_Terminal*)
		Notes.Set(Notes_Code*)
		Notes.Set(Notes_Tech*)
		Notes.Set(Notes_Info*)
		Notes.Set(Notes_Long*)
		Notes.Set(Notes_Math*)
		Notes.Set(Notes_Git*)
		Notes.Set(Notes_Vim*)
		return Notes
	}

	static _GenerateLinksMap() {
		Links := Map()
		Links.Set(Links_General*)
		Links.Set(Links_Channel*)
		Links.Set(Links_Memes*)
		Links.Set(Links_Tools*)
		Links.Set(Links_Docs*)
		Links.Set(Links_AhkLib*)
		Links.Set(Links_DiscordPins*)
		Links.Set(Links_Github*)
		Links.Set(Links_Fonts*)
		return Links
	}

}