#Include <Abstractions\Registers>
#Include <Tools\Info>
#Include <Converters\DateTime>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Abstractions\Mouse>
#Include <System\UIA>
#Include <Tools\StateBulb>
#Include <App\Git>
#Include <Utils\Win>

class Spotify {

	static exeTitle := "ahk_exe Spotify.exe"
	static winTitle := Spotify.exeTitle
	static path := A_AppData "\Spotify\Spotify.exe"

	static winObj := Win({
		winTitle: Spotify.exeTitle,
		exePath: Spotify.path
	})

	static realTitle {
		get => WinGetTitle(Spotify.winTitle)
	}

	static CurrentSongName {
		get => Spotify.UIA.CurrentTrack.Name
	}

	static FirstArtistName {
		get => Spotify.UIA.FirstArtist.Name
	}

	static Close() => Send("^+q")

	static LikedPlaylist() => Spotify.UIA.LikedPlaylistElement.Click()
	static SkipNext()      => Spotify.UIA.SkipNextElement.Click()
	static SkipPrev()      => Spotify.UIA.SkipPrevElement.Click()
	static Like()          => Spotify.UIA.LikeState := true
	static Dislike()       => Spotify.UIA.LikeState := false
	static ToggleLike()    => Spotify.UIA.LikeState := !Spotify.UIA.LikeState
	static YesShuffle()    => Spotify.UIA.ShuffleState := true
	static NoShuffle()     => Spotify.UIA.ShuffleState := false
	static ToggleShuffle() => Spotify.UIA.ShuffleElement.Toggle()
	static PlayPauseCurrentView() => Spotify.UIA.ViewPlayButton.Click()

	static AddToQueue() {
		Click("R")
		Spotify.UIA.AddToQueueElement.Click()
	}

	static Context() {
		MouseGetPos(&x, &y)
		Spotify.UIA.CurrentTrack.Click("R")
		MouseMove(x, y)
	}

	static ArtistContext() {
		MouseGetPos(&x, &y)
		Spotify.UIA.FirstArtist.Click("R")
		MouseMove(x, y)
	}

	static TrashTrack() {
		Spotify.Dislike()
		Spotify.RemoveFromCurrentPlaylist()
		Spotify.SkipNext()
	}

	static RemoveFromCurrentPlaylist() {
		Spotify.Context()
		Spotify.UIA.RemoveFromPlaylistElement.Click()
	}

	static AddToPlaylist(playlistName) {
		contextMenu := Spotify.UIA.ContextMenu
		contextMenu.FindElement({
			Name: "Add to playlist"
		}).Click()
		contextMenu.WaitElement({
			Name: playlistName
		}).Click()
	}

	static AddCurrentToBest() {
		Spotify.Context()
		Spotify.AddToPlaylist("Best")
		Spotify.Like()
	}

	static CopyArtistTrack() {
		artistAndTrack := Spotify.FirstArtistName " - " Spotify.CurrentSongName
		A_Clipboard := artistAndTrack
		Info("copied: " artistAndTrack)
	}

	static CopyArtist() {
		artistName := Spotify.FirstArtistName
		A_Clipboard := artistName
		Info("copied: " artistName)
	}

	static CopyLink() {
		Spotify.Context()
		Spotify.UIA.ShareElement.Click()
		Spotify.UIA.CopySongLinkElement.Click()
	}

	static AutoNewDiscovery() => Spotify.NewDiscovery(Spotify.FirstArtistName)

	static NewDiscovery(artistName) {
		AppendFile(Paths.Ptf["Discovery log"], DateTime.Date " " DateTime.Time " - " artistName "`n")
		Info(artistName " just discovered! 🌎")
		Git(Paths.Music)
			.Add(Paths.Ptf["Discovery log"])
			.Commit("discover " artistName)
			.Push()
			.Execute()
		Info("pushed!")
	}

	static NewRapper(artistName) {
		if Spotify._IsRapperTouched(artistName)
			return
		AppendFile(Paths.Ptf["Rappers"], DateTime.Date " " DateTime.Time " - " artistName "`n")
		Info(artistName " yet to be discovered! 📃")
		Git(Paths.Music)
			.Add(Paths.Ptf["Rappers"])
			.Commit("interest " artistName)
			.Push()
			.Execute()
		Info("pushed!")
	}

	static AutoFavRapper() {
		Spotify.ArtistContext()
		if !Spotify.UIA.FollowState
			Spotify.UIA.FollowButton.Click()
		Spotify.FavRapper(Spotify.FirstArtistName)
	}

	static FavRapper(artistName) {
		if Spotify._IsRapperFavorite(artistName)
			return
		AppendFile(Paths.Ptf["Artists"], "1. " DateTime.Date " - " artistName "`n")
		Info(artistName " is now your favorite! 🥰")
		Git(Paths.Music)
			.Add(Paths.Ptf["Artists"])
			.Commit("favorite " artistName)
			.Push()
			.Execute()
		Info("pushed!")
	}

	static Discovery() {
		static isStarted := false
		static var := 0
		if isStarted {
			Destruction()
			return
		}
		onRightClick(*) {
			Mouse.ControlClick_Here(Spotify.exeTitle, "R")
			var++
			g_added_text.Text := var
			Spotify.AddToPlaylist("Discovery")
			if var >= 15 {
				Destruction()
			}
		}
		Destruction(*) {
			HotIfWinActive(Spotify.winTitle)
			Hotkey("RButton", "Off")
			Hotkey("Escape", "Off")
			g_added.Destroy()
			var := 0
			isStarted := false
		}
		static g_added
		g_added := Gui("AlwaysOnTop -Caption")
		g_added.backColor := "171717"
		g_added.SetFont("s50 c0xC5C5C5", "Consolas")
		g_added_text := g_added.Add("Text", "W200 X0 Y60 Center", "0")
		g_added.Show("W200 H200 X0 Y0 NA")
		HotIfWinActive(Spotify.winTitle)
		Hotkey("RButton", onRightClick, "On")
		Hotkey("Escape", Destruction, "On")
		g_added.OnEvent("Close", Destruction.Bind())
		g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
		g_added_text.OnEvent("DoubleClick", Destruction.Bind())
		isStarted := true
	}


	static _RemoveAfterArtist(input) => RegExReplace(input, " +[-=] .*")

	static _RemoveDateAndTime(input) => RegExReplace(input, "(\d+\. )?(- +)?(\d\d\.\d\d\.\d\d)?( \d\d:\d\d)?( +- +)?")

	static _IsRapperTouched(name) {
		isTouched := ReadFile(Paths.Ptf["Unfinished"])
		isTouched .= ReadFile(Paths.Ptf["Rappers"])
		isTouched .= ReadFile(Paths.Ptf["Artists"])
		isTouched := Spotify._RemoveDateAndTime(isTouched)
		isTouched := Spotify._RemoveAfterArtist(isTouched)
		if Instr(isTouched, name) {
			Info("You've already started listening to this rapper")
			return true
		}
		return false
	}

	static _IsRapperFavorite(artistName) {
		artists := Spotify._RemoveDateAndTime(ReadFile(Paths.Ptf["Artists"]))
		if InStr(artists, artistName) {
			Info(artistName " is already added 😨")
			return true
		}
		return false
	}


	class UIA {

		static UserName := "Axlefublr"

		static Document {
			get => UIA.ElementFromHandle(Spotify.winTitle).FindElement({
				Type: "document",
				Scope: 2
			})
		}

		static ArtistContextMenu {
			get => this.Document.WaitElement({
				Type: "Menu",
				Scope: 2,
				Order: 2
			})
		}

			static FollowButton {
				get => this.ArtistContextMenu.FindElement({
					Name: "ollow",
					Matchmode: "Substring"
				})
			}

				static FollowState {
					get => this.FollowButton.Name = "Follow" ? false : true
				}

		static ContextMenu {
			get => this.Document.WaitElement({
				Type: "menu",
				Scope: 2
			})
		}

			static RemoveFromPlaylistElement {
				get => this.ContextMenu.WaitElement({
					Name: "Remove from this playlist",
					Type: "MenuItem",
					Scope: 2
				})
			}

			static AddToQueueElement {
				get => this.ContextMenu.WaitElement({
					Name: "Add to queue"
				})
			}

			static ShareElement {
				get => this.ContextMenu.WaitElement({
					Name: "Share"
				})
			}

			static CopySongLinkElement {
				get => this.ContextMenu.WaitElement({
					Name: "Copy Song Link",
					Order: 2
				})
			}

		static MainNavigation {
			get => this.Document.WaitElement({
				Type:          "Group",
				LocalizedType: "navigation",
				Name:          "Main",
				Scope:         2
			})
		}

			static YourLibraryGroup {
				get => this.MainNavigation.WaitElement({
					Type:  "Group",
					Scope: 2
				})
			}

				static YourLibraryList {
					get => this.YourLibraryGroup.FindElement({
						Type:  "List",
						Name:  "Your Library",
						Scope: 2
					})
				}

					static LikedPlaylistElement {
						get => this.YourLibraryList.FindElement({
							Type: "Button",
							Name: "Liked Songs",
							Matchmode: "Substring"
						})
					}

		static ContentInfo {
			get => this.Document.WaitElement({
				LocalizedType: "content info",
				Type: "Group",
				Scope: 2
			})
		}

			static InnerContentInfo {
				get => this.ContentInfo.WaitElement({
					LocalizedType: "content info",
					Type: "Group",
					Scope: 2
				})
			}

				static CurrentTrack {
					get => this.InnerContentInfo.FindElement({
						Type: "Link"
					})
				}

				static FirstArtist {
					get => this.InnerContentInfo.FindElement({
						Type: "Link",
						Index: 2
					})
				}

				static LikeElement {
					get => this.InnerContentInfo.WaitElement({
						Type: "Button",
						Name: "Library",
						Matchmode: "Substring",
						Scope: 2
					})
				}

					static LikeState {
						get => this.LikeElement.ToggleState
						set => this.LikeElement.ToggleState := value
					}

			static SkipNextElement {
				get => this.ContentInfo.WaitElement({
					Name: "Next",
					Type: "Button",
					Scope: 2
				})
			}

			static SkipPrevElement {
				get => this.ContentInfo.WaitElement({
					Name: "Previous",
					Type: "Button",
					Scope: 2
				})
			}

			static ShuffleElement {
				get => this.ContentInfo.WaitElement({
					Type: "Button",
					Name: "shuffle",
					Matchmode: "Substring",
					Scope: 2
				})
			}

				static ShuffleState {
					get => this.ShuffleElement.ToggleState
					set => this.ShuffleElement.ToggleState := value
				}

		static MainView {
			get => this.Document.WaitElement({
				LocalizedType: "main",
				Scope: 2
			})
		}

			static ViewPlayButton {
				get => this.MainView.WaitElement({
					Type: "Button",
					Name: "Play|Pause .*",
					Matchmode: "Regex",
					Scope: 2
				})
			}

	}

	class PlaylistSorter {

		static MaxPlaylist := 50
		static Step := 9
		static BulbIndex := 4
		static MoveInPixels := 78
		static Hotkey := "~RButton"

		static bfAddTrack := (ThisHotkey) => this.AddTrack()

		static CounterFile {
			get => ReadFile(Paths.Ptf["playlist-sorter"])
			set => WriteFile(Paths.Ptf["playlist-sorter"], value)
		}

		static AddTrack() {
			counter := this.CounterFile
			counter += this.Step
			if counter > this.MaxPlaylist
				counter -= this.MaxPlaylist
			this.CounterFile := counter
			Spotify.AddToPlaylist("#" counter)
			this._CorrectMousePosition()
		}

		static ToggleHotkey() {
			static isHotkeyActive := false
			if isHotkeyActive {
				Hotkey(this.Hotkey, this.bfAddTrack, "Off")
				StateBulb[this.BulbIndex].Destroy()
			}
			else {
				Hotkey(this.Hotkey, this.bfAddTrack, "On")
				StateBulb[this.BulbIndex].Create()
			}
			isHotkeyActive := !isHotkeyActive
		}


		static _CorrectMousePosition() {
			CoordMode("Mouse", "Screen")
			MouseMove(0, -this.MoveInPixels,, "R")
			if (MouseGetPos(, &y), y) < 208
				MouseMove(1027, 782)
		}
	}

	class Errors {
		class SpotifyNotActiveError extends Error {
			__New() {
				this.Message := "Spotify has to be the active window for this to work"
			}
		}
	}
}
