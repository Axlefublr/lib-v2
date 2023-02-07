#Include <App\Telegram>

#HotIf WinActive(Telegram.winTitle)

!sc33::Telegram.PrevChannel()
!sc34::Telegram.NextChannel()

^sc33::Telegram.PrevFolder()
^sc34::Telegram.NextFolder()

#HotIf