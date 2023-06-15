#Include <Abstractions\Registers>
#Include <Utils\Press>
#Include <App\Telegram>

#HotIf WinActive(Telegram.winTitle)

!e::Registers("d").Paste().Truncate()

!sc33::Telegram.PrevChannel()
!sc34::Telegram.NextChannel()

^sc33::Telegram.PrevFolder()
^sc34::Telegram.NextFolder()

XButton1 & f::Telegram.Voice()
XButton1 & s::Telegram.Scroll()

#HotIf