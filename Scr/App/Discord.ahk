#Include <Abstractions\Registers>
#Include <App\Discord>

#HotIf WinActive(Discord.winTitle,, Discord.excludeTitle)

!e::Registers("d").Paste().Truncate()
^m::Discord.ToggleMentions()

; sc33 is a , and sc34 is a .
!sc33::Discord.PrevChannel()
!sc34::Discord.NextChannel()

+!sc33::Discord.PrevUnreadChannel()
+!sc34::Discord.NextUnreadChannel()

^+sc33::Discord.PrevServer()
^+sc34::Discord.NextServer()

#HotIf