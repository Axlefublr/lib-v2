#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.UIA.TrashTrack()

!w::Spotify.UIA.ToggleLike()
!e::Spotify.UIA.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()
#HotIf