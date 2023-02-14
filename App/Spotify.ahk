#Include <Tools\Info>
#Include <Converters\DateTime>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Abstractions\Mouse>
#Include <System\UIA>

Class Spotify {

    static exeTitle := "ahk_exe Spotify.exe"
    static winTitle := Spotify.exeTitle
    static path := A_AppData "\Spotify\Spotify.exe"

    static winObj := Win({
        winTitle: Spotify.exeTitle,
        exePath: Spotify.path
    })

    static Like() => Send("+!b")

    static Shuffle() => Send("^s")

    static SkipNext() => Send("^{Right}")

    static SkipPrev() => Send("^{Left}")

    static LikedPlaylist() => Send("+!s")

    static Close() => Send("^+q")

    static RemoveAfterArtist(input) => RegExReplace(input, " +[-=] .*")

    static RemoveDateAndTime(input) => RegExReplace(input, "(\d+\. )?(- +)?(\d\d\.\d\d\.\d\d)?( \d\d:\d\d)?( +- +)?")

    static Context() => (
        ControlClick("x32 y1014", Spotify.exeTitle, , "R")
    )

    class UIA extends Spotify {

        static __GetDocument() {
            UIAObject := UIA.ElementFromHandle(Spotify.winTitle)
            document := UIAObject.FindElement({
                Type: "document",
                Scope: 2
            })
            return document
        }

        static __GetContextMenu() {
            songMenu := Spotify.UIA.__GetDocument().WaitElement({
                Type: "menu",
                Scope: 2
            })
            return songMenu
        }

        static __GetContentInfo() {
            contentInfo := Spotify.UIA.__GetDocument().FindElement({
                LocalizedType: "content info",
                Type: "Group",
                Scope: 2
            })
            return contentInfo
        }

        static __GetInnerContentInfo() {
            innerContentInfo := Spotify.UIA.__GetContentInfo().WaitElement({
                LocalizedType: "content info",
                Type: "Group",
                Scope: 2
            })
            return innerContentInfo
        }

        static __GetMainNavigation() {
            mainNavigation := Spotify.UIA.__GetDocument().FindElement({
                Type:"Group",
                LocalizedType:"navigation",
                Name:"Main",
                Scope: 2
            })
            return mainNavigation
        }

        static RemoveCurrTrack() {

        }

        static LikedPlaylist() {
            Spotify.UIA.__GetMainNavigation().FindElement({
                Type:"Link",
                Name:"Liked Songs",
                Scope: 2
            }).Click()
        }

        static ToggleLike() {
            Spotify.UIA.__GetInnerContentInfo().WaitElement({
                LocalizedType: "button",
                Type: "Button",
                Scope: 2
            }).Click()
        }

        static ToggleShuffle() {
            Spotify.UIA.__GetContentInfo().FindElement({
                Type: "Button",
                ; Name: "shuffle",
                Scope: 2
            }).Click()
        }

        static AddToPlaylist(playlistName) {
            contextMenu := Spotify.UIA.__GetContextMenu()
            contextMenu.FindElement({
                Name: "Add to playlist"
            }).Click()
            contextMenu.WaitElement({
                Name: playlistName
            }).Click()
        }

        static AddCurrentToBest() {
            Spotify.Context()
            Spotify.UIA.AddToPlaylist("Best")
        }

    }

    class PlaylistSorter extends Spotify {

        static MaxPlaylist := 20

        static AddTrack() {
            counter := ReadFile(Paths.Ptf["playlist-sorter"])
            super.AddToPlaylist("#" counter)
            if counter >= Spotify.PlaylistSorter.MaxPlaylist
                counter := 0
            WriteFile(Paths.Ptf["playlist-sorter"], ++counter)
        }

        static bfAddTrack := (ThisHotkey) => Spotify.PlaylistSorter.AddTrack()

        static ToggleHotkey() {
            static isHotkeyActive := false
            if isHotkeyActive {
                Hotkey("~RButton", Spotify.PlaylistSorter.bfAddTrack, "Off")
                Info("Hotkey disabled")
            }
            else {
                Hotkey("~RButton", Spotify.PlaylistSorter.bfAddTrack, "On")
                Info("Hotkey enabled")
            }
            isHotkeyActive := !isHotkeyActive
        }
    }

    static GetCurrSong() {
        currSong := WinGetTitle(Spotify.exeTitle)
        if currSong ~= "Spotify (Free)|(Premium)" {
            Info("No song is currently playing")
            return false
        }
        return currSong
    }

    static GetCurrArtist() {
        artistAndSong := Spotify.GetCurrSong()
        return Spotify.RemoveAfterArtist(artistAndSong)
    }

    static NewDiscovery() {
        currSong := Spotify.GetCurrSong()
        if !currSong {
            return
        }
        artistName := Spotify.RemoveAfterArtist(currSong)
        Spotify.NewDiscovery_Manual(artistName)
    }

    static NewDiscovery_Manual(artistName) {
        AppendFile(Paths.Ptf["Discovery log"], DateTime.Date " " DateTime.Time " - " artistName "`n")
        Info(artistName " just discovered! 🌎")
    }

    static IsRapperTouched(name) {
        isTouched := ReadFile(Paths.Ptf["Unfinished"])
        isTouched .= ReadFile(Paths.Ptf["Rappers"])
        isTouched .= ReadFile(Paths.Ptf["Artists"])
        isTouched := Spotify.RemoveDateAndTime(isTouched)
        isTouched := Spotify.RemoveAfterArtist(isTouched)
        if Instr(isTouched, name) {
            Info("You've already started listening to this rapper")
            return true
        }
        return false
    }

    static NewRapper(name) {
        if Spotify.IsRapperTouched(name)
            return
        AppendFile(Paths.Ptf["Rappers"], DateTime.Date " " DateTime.Time " - " name "`n")
        Info(name " yet to be discovered! 📃")
    }

    static FavRapper_Auto() {
        currSong := Spotify.GetCurrSong()
        if !currSong {
            return
        }
        currArtist := Spotify.RemoveAfterArtist(currSong)
        Spotify.FavRapper_Manual(currArtist)
    }

    static FavRapper_Manual(artistName) {
        artists := Spotify.RemoveDateAndTime(ReadFile(Paths.Ptf["Artists"]))
        if InStr(artists, artistName) {
            Info(artistName " is already added 😨")
            return
        }
        AppendFile(Paths.Ptf["Artists"], "1. " DateTime.Date " - " artistName "`n")
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
            ControlClick_Here(Spotify.exeTitle, "R")
            var++
            g_added_text.Text := var
            Spotify.UIA.AddToPlaylist("Discovery")
            if var >= 15 {
                Destruction()
            }
        }

        Destruction(*) {
            HotIfWinActive(Spotify.exeTitle)
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

        HotIfWinActive(Spotify.exeTitle)
        Hotkey("RButton", onRightClick, "On")
        Hotkey("Escape", Destruction, "On")
        g_added.OnEvent("Close", Destruction.Bind())
        g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
        g_added_text.OnEvent("DoubleClick", Destruction.Bind())

        isStarted := true
    }
}
