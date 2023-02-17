#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.TrashTrack()

!w::Spotify.ToggleLike()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()
#HotIf