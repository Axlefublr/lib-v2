#Include <Utils\Win>

#InputLevel 6

#!k::Send("{WheelUp}")
#!j::Send("{WheelDown}")
#!l::Send("{PgDn}")
#!h::Send("{PgUp}")

#^h::Win.RestoreLeftRight("left")
#^l::Win.RestoreLeftRight("right")
#^k::Win.Maximize()
#^j::Win.RestoreDown()

>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next

#InputLevel 5
