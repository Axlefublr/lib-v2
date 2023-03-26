#Include <Tools\ToggleInfo>
#Include <Tools\StateBulb>
#Include <Environment>
#Include <Abstractions\Mouse>

ToggleVimMode() {
    Environment.VimMode := !Environment.VimMode
    if Environment.VimMode
        StateBulb[1].Create()
    else
        StateBulb[1].Destroy()
}
!Space::ToggleVimMode()

#HotIf Environment.VimMode

s::Mouse.MoveLeft(Mouse.MediumMove)
d::Mouse.MoveUp(Mouse.MediumMove)
f::Mouse.MoveDown(Mouse.MediumMove)
g::Mouse.MoveRight(Mouse.MediumMove)

+s::Mouse.MoveLeft(Mouse.SmallMove)
+d::Mouse.MoveUp(Mouse.SmallMove)
+f::Mouse.MoveDown(Mouse.SmallMove)
+g::Mouse.MoveRight(Mouse.SmallMove)

^s::Mouse.MoveLeft(Mouse.BigMove)
^d::Mouse.MoveUp(Mouse.BigMove)
^f::Mouse.MoveDown(Mouse.BigMove)
^g::Mouse.MoveRight(Mouse.BigMove)

*r::Click()
*w::Click("Right")
*e::Click("Middle")
#r::Mouse.HoldIfUp("L")
#w::Mouse.HoldIfUp("R")
#e::Mouse.HoldIfUp("M")

1::MouseMove(Mouse.FarLeftX,        Mouse.MiddleY)
2::MouseMove(Mouse.LowLeftX,        Mouse.MiddleY)
3::MouseMove(Mouse.MiddleLeftX,     Mouse.MiddleY)
4::MouseMove(Mouse.HighLeftX,       Mouse.MiddleY)
5::MouseMove(Mouse.LessThanMiddleX, Mouse.MiddleY)
6::MouseMove(Mouse.MoreThanMiddleX, Mouse.MiddleY)
7::MouseMove(Mouse.LowRightX,       Mouse.MiddleY)
8::MouseMove(Mouse.MiddleRightX,    Mouse.MiddleY)
9::MouseMove(Mouse.HighRightX,      Mouse.MiddleY)
0::MouseMove(Mouse.FarRightX,       Mouse.MiddleY)

+1::MouseMove(Mouse.FarLeftX,        Mouse.TopY)
+2::MouseMove(Mouse.LowLeftX,        Mouse.TopY)
+3::MouseMove(Mouse.MiddleLeftX,     Mouse.TopY)
+4::MouseMove(Mouse.HighLeftX,       Mouse.TopY)
+5::MouseMove(Mouse.LessThanMiddleX, Mouse.TopY)
+6::MouseMove(Mouse.MoreThanMiddleX, Mouse.TopY)
+7::MouseMove(Mouse.LowRightX,       Mouse.TopY)
+8::MouseMove(Mouse.MiddleRightX,    Mouse.TopY)
+9::MouseMove(Mouse.HighRightX,      Mouse.TopY)
+0::MouseMove(Mouse.FarRightX,       Mouse.TopY)

^1::MouseMove(Mouse.FarLeftX,        Mouse.BottomY)
^2::MouseMove(Mouse.LowLeftX,        Mouse.BottomY)
^3::MouseMove(Mouse.MiddleLeftX,     Mouse.BottomY)
^4::MouseMove(Mouse.HighLeftX,       Mouse.BottomY)
^5::MouseMove(Mouse.LessThanMiddleX, Mouse.BottomY)
^6::MouseMove(Mouse.MoreThanMiddleX, Mouse.BottomY)
^7::MouseMove(Mouse.LowRightX,       Mouse.BottomY)
^8::MouseMove(Mouse.MiddleRightX,    Mouse.BottomY)
^9::MouseMove(Mouse.HighRightX,      Mouse.BottomY)
^0::MouseMove(Mouse.FarRightX,       Mouse.BottomY)

j::Down
k::Up
h::Left
l::Right
i::Home
o::End
u::PgUp
p::PgDn
*z::SendInput("{Blind}{Click WheelLeft}") ; Solution by childfs6865
*x::SendInput("{Blind}{Click WheelUp}")
*c::SendInput("{Blind}{Click WheelDown}")
*v::SendInput("{Blind}{Click WheelRight}")

a::Volume_Down
q::Volume_Up
t::Media_Play_Pause
m::Volume_Mute
sc33::MediaActions.SkipPrev()
sc34::MediaActions.SkipNext()

`::return
-::return
=::return
sc1A::return
sc1B::return
sc2B::return
sc27::return
sc28::return
sc35::return

#HotIf