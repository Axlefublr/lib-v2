#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.RemoveFromCurrentPlaylist()
F3::Spotify.TrashTrack()
F4::Spotify.ToggleShuffle()

F5::Spotify.AutoNewDiscovery()
F8::Spotify.AutoFavRapper()

!w::Spotify.ToggleLike()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()

MButton::Spotify.AddToQueue()
#HotIf