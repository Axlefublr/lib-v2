#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)
!w::Spotify.Like()
!e::Spotify.LikedPlaylist()

PgDn::Spotify.SkipNext()
PgUp::Spotify.SkipPrev()
#HotIf