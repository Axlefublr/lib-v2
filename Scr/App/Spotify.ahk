#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)

F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.RemoveFromCurrentPlaylist()
F3::Spotify.TrashTrack()
F4::Spotify.ToggleShuffle()

F5::Spotify.AutoNewDiscovery()
F6::Spotify.CopyArtistTrack()
F7::Spotify.CopyArtist()
F8::Spotify.AutoFavRapper()
F9::Spotify.PlayOldestPlaylist()

!w::Spotify.ToggleLike()
!e::Spotify.LikedPlaylist()

MButton::Spotify.AddToQueue()

XButton1:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight:    Spotify.TrashTrack()
        Case sections.bottomRight: Spotify.Discovery()
        Case sections.topLeft:     Spotify.AddCurrentToBest()
        Case sections.bottomLeft:  Spotify.RemoveFromCurrentPlaylist()
        Case sections.up:          Spotify.AutoNewDiscovery()
        Case sections.down:        Spotify.ToggleShuffle()
        Case sections.middle:      Spotify.ToggleLike()
    }
}

#HotIf