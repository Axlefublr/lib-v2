#Include <Tools\Info>
#Include <Converters\DateTime>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Abstractions\Mouse>
#Include <System\UIA>
#Include <Tools\StateBulb>
#Include <App\Git>

Class Spotify {

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
    static ToggleShuffle() => Spotify.UIA.ShuffleState := Spotify.UIA.ShuffleState

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

    static PlayOldestPlaylist() {
        Spotify.YesShuffle()
        Spotify.UIA.YourLibraryButton.Click()
        Spotify.UIA.OldestPlaylistPlayButton.Click()
    }

    static PlayDiscovery() {
        Spotify.NoShuffle()
        Spotify.UIA.YourLibraryButton.Click()
        Spotify.UIA.DiscoveryPlaylistPlayButton.Click()
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
        Git(Paths.Music).Add(Paths.Ptf["Discovery log"]).Commit("discover " artistName).Push().Execute()
        Info(artistName " just discovered! 🌎")
    }

    static NewRapper(artistName) {
        if Spotify._IsRapperTouched(artistName)
            return
        AppendFile(Paths.Ptf["Rappers"], DateTime.Date " " DateTime.Time " - " artistName "`n")
        Git(Paths.Music).Add(Paths.Ptf["Rappers"]).Commit("interest " artistName).Push().Execute()
        Info(artistName " yet to be discovered! 📃")
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
        Git(Paths.Music).Add("Artists").Commit("favorite " artistName).Push().Execute()
        Info(artistName " is now your favorite! 🥰")
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

        static Document {
            get => UIA.ElementFromHandle(Spotify.winTitle).FindElement({
                Type: "document",
                Scope: 2
            })
        }

        static ArtistContextMenu {
            get => Spotify.UIA.Document.WaitElement({
                Type: "Menu",
                Scope: 2,
                Order: 2
            })
        }

            static FollowButton {
                get => Spotify.UIA.ArtistContextMenu.FindElement({
                    Name: "ollow",
                    Matchmode: "Substring"
                })
            }

                static FollowState {
                    get => Spotify.UIA.FollowButton.Name = "Follow" ? false : true
                }

        static ContextMenu {
            get => Spotify.UIA.Document.WaitElement({
                Type: "menu",
                Scope: 2
            })
        }

            static RemoveFromPlaylistElement {
                get => Spotify.UIA.ContextMenu.WaitElement({
                    Name: "Remove from this playlist",
                    Type: "MenuItem",
                    Scope: 2
                })
            }

            static AddToQueueElement {
                get => Spotify.UIA.ContextMenu.WaitElement({
                    Name: "Add to queue"
                })
            }

            static ShareElement {
                get => Spotify.UIA.ContextMenu.WaitElement({
                    Name: "Share"
                })
            }

            static CopySongLinkElement {
                get => Spotify.UIA.ContextMenu.WaitElement({
                    Name: "Copy Song Link",
                    Order: 2
                })
            }

        static ContentInfo {
            get => Spotify.UIA.Document.WaitElement({
                LocalizedType: "content info",
                Type: "Group",
                Scope: 2
            })
        }

            static InnerContentInfo {
                get => Spotify.UIA.ContentInfo.WaitElement({
                    LocalizedType: "content info",
                    Type: "Group",
                    Scope: 2
                })
            }

                static CurrentTrack {
                    get {
                        try return Spotify.UIA.InnerContentInfo.FindElement({
                            Type: "Link"
                        })
                        throw Spotify.Errors.SpotifyNotActiveError()
                    }
                }

                static FirstArtist {
                    get {
                        try return Spotify.UIA.InnerContentInfo.FindElement({
                            Type: "Link",
                            Index: 2
                        })
                        throw Spotify.Errors.SpotifyNotActiveError()
                    }
                }

                static LikeElement {
                    get => Spotify.UIA.InnerContentInfo.WaitElement({
                        LocalizedType: "button",
                        Type: "Button",
                        Scope: 2
                    })
                }

                    static LikeState {
                        get => Spotify.UIA.LikeElement.ToggleState
                        set => Spotify.UIA.LikeElement.ToggleState := value
                    }

            static SkipNextElement {
                get => Spotify.UIA.ContentInfo.WaitElement({
                    Name: "Next",
                    Type: "Button",
                    Scope: 2
                })
            }

            static SkipPrevElement {
                get => Spotify.UIA.ContentInfo.WaitElement({
                    Name: "Previous",
                    Type: "Button",
                    Scope: 2
                })
            }

            static ShuffleElement {
                get => Spotify.UIA.ContentInfo.WaitElement({
                    Type: "Button",
                    Name: "shuffle",
                    Matchmode: "Substring",
                    Scope: 2
                })
            }

                static ShuffleState {
                    get => Spotify.UIA.ShuffleElement.ToggleState
                    set => Spotify.UIA.ShuffleElement.ToggleState := value
                }

        static MainNavigation {
            get => Spotify.UIA.Document.WaitElement({
                Type:          "Group",
                LocalizedType: "navigation",
                Name:          "Main",
                Scope:         2
            })
        }

            static LikedPlaylistElement {
                get => Spotify.UIA.MainNavigation.FindElement({
                    Type:"Link",
                    Name:"Liked Songs",
                    Scope: 2
                })
            }

            static YourLibraryButton {
                get => Spotify.UIA.MainNavigation.FindElement({
                    Name: "Your Library",
                    Type: "Link"
                })
            }

        static YourLibraryElement {
            get => Spotify.UIA.Document.WaitElement({
                Name: "Spotify – Your Library",
                LocalizedType: "main",
                Scope: 2
            })
        }

            static OldestPlaylistPlayButton {
                get => Spotify.UIA.YourLibraryElement.WaitElement({
                    Name:      "Play #\d+",
                    Matchmode: "Regex",
                    Type:      "Button",
                    Scope:     2,
                    Order:     2
                })
            }

            static DiscoveryPlaylistPlayButton {
                get => Spotify.UIA.YourLibraryElement.WaitElement({
                    Name: "Play Discovery",
                    Type: "Button",
                    Scope: 2
                })
            }

    }

    class PlaylistSorter {

        static MaxPlaylist := 20
        static Step := 3
        static BulbIndex := 4

        static bfAddTrack := (ThisHotkey) => Spotify.PlaylistSorter.AddTrack()

        static CounterFile {
            get => ReadFile(Paths.Ptf["playlist-sorter"])
            set => WriteFile(Paths.Ptf["playlist-sorter"], value)
        }

        static AddTrack() {
            counter := Spotify.PlaylistSorter.CounterFile
            counter += Spotify.PlaylistSorter.Step
            if counter > Spotify.PlaylistSorter.MaxPlaylist
                counter -= Spotify.PlaylistSorter.MaxPlaylist
            Spotify.PlaylistSorter.CounterFile := counter
            Spotify.AddToPlaylist("#" counter)
        }

        static ToggleHotkey() {
            static isHotkeyActive := false
            if isHotkeyActive {
                Hotkey("~RButton", Spotify.PlaylistSorter.bfAddTrack, "Off")
                StateBulb[Spotify.PlaylistSorter.BulbIndex].Destroy()
            }
            else {
                Hotkey("~RButton", Spotify.PlaylistSorter.bfAddTrack, "On")
                StateBulb[Spotify.PlaylistSorter.BulbIndex].Create()
            }
            isHotkeyActive := !isHotkeyActive
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
