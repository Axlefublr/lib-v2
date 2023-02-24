#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.UIA.RemoveFromCurrentPlaylist()

!w::Spotify.ToggleLike()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()

MButton::Spotify.AddToQueue()
#HotIf