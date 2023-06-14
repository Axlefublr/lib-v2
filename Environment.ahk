#Include <Notes\Rust>
#Include <Notes\Vim>
#Include <Notes\Long>
#Include <Notes\Git>
#Include <Notes\Math>
#Include <Notes\Code>
#Include <Notes\Info>
#Include <Notes\Tech>
#Include <Notes\Terminal>
#Include <Extensions\Map>
#Include <Tools\StateBulb>

class Environment {

	static Notes := this._GenerateNotesMap()

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
		Notes.Set(Notes_Rust*)
		return Notes
	}

}