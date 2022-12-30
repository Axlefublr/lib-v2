#Include <App\Youtube>
#Include <ClipSend>
#Include <Text>
#Include <Paths>
#Include <Win>

#HotIf WinActive(Youtube.Studio)
:O:msc::My second channel!
:O:mmc::My main channel!
:O:ahk::Ahk all the way!
:XO:desc::ClipSend(ReadFile(Paths.Ptf["Description"]) "`n`n")

#HotIf Win({winTitle: Youtube.NotWatchingVideo}).ActiveRegex()
Escape::Youtube.MiniscreenClose()

#HotIf WinActive(Youtube.winTitle)
PgDn::Youtube.SkipNext()
PgUp::Youtube.SkipPrev()
#HotIf