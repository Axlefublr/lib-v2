#Include <App\Spotify>

#HotIf WinActive(Spotify.exeTitle)

F1::Spotify.PlaylistSorter.ToggleHotkey()
F2::Spotify.RemoveFromCurrentPlaylist()
F3::Spotify.TrashTrack()
F4::Spotify.ToggleShuffle()

F5::Spotify.AutoNewDiscovery()
F6::Spotify.CopyArtistTrack()
F7::Spotify.CopyLink()
F8::Spotify.AutoFavRapper()
F9::return
F10::return
F11::Spotify.CopyArtist()
F12::return

!w::Spotify.ToggleLike()
!e::Spotify.LikedPlaylist()

MButton::Spotify.AddToQueue()

XButton1 & d::Spotify.TrashTrack()
XButton1 & r::Spotify.Discovery()
XButton1 & e::Spotify.AddCurrentToBest()
XButton1 & q::Spotify.RemoveFromCurrentPlaylist()
XButton1 & v::Spotify.AutoNewDiscovery()
XButton1 & s::Spotify.ToggleShuffle()
XButton1 & w::Spotify.ToggleLike()
XButton1 & z::Spotify.AutoFavRapper()
XButton1 & a::Spotify.PlaylistSorter.ToggleHotkey()

#HotIf