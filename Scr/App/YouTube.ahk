#Include <App\Youtube>
#Include <Utils\ClipSend>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>

#HotIf WinActive(Youtube.winTitle)
PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()
#HotIf