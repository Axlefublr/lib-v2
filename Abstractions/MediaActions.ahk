#Include <App\Youtube>
#Include <App\Spotify>

class MediaActions {

	static SkipNext() {
		className := MediaActions._GetMediaClass()
		if !className {
			Send("{Media_Next}")
			return
		}
		%className%.SkipNext()
	}

	static SkipPrev() {
		className := MediaActions._GetMediaClass()
		if !className {
			Send("{Media_Prev}")
			return
		}
		%className%.SkipPrev()
	}


	static _GetMediaClass() {
		Switch {
			case WinActive(Youtube.winTitle):return "Youtube"
			case WinActive(Spotify.winTitle):return "Spotify"
			default:return ""
		}
	}

}
