#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.PlaylistCounter.Show()
F3::Spotify.PlaylistCounter.IncrementAndShow()

!w::Spotify.Like()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()
#HotIf