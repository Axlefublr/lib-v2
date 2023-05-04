#Include <Tools\CleanInputBox>
#Include <Tools\Counter>
#Include <App\Screenshot>
#Include <Abstractions\WindowManager>
#Include <Abstractions\MediaActions>
#Include <Tools\ToggleInfo>
#Include <Tools\StateBulb>
#Include <Environment>
#Include <Abstractions\Mouse>

!Space::Environment.VimMode := !Environment.VimMode

#HotIf Environment.WindowManagerMode

h::WindowManager().MoveLeft(Mouse.MediumMove)
k::WindowManager().MoveUp(Mouse.MediumMove)
j::WindowManager().MoveDown(Mouse.MediumMove)
l::WindowManager().MoveRight(Mouse.MediumMove)

+h::WindowManager().MoveLeft(Mouse.SmallMove)
+k::WindowManager().MoveUp(Mouse.SmallMove)
+j::WindowManager().MoveDown(Mouse.SmallMove)
+l::WindowManager().MoveRight(Mouse.SmallMove)

^h::WindowManager().MoveLeft(Mouse.BigMove)
^k::WindowManager().MoveUp(Mouse.BigMove)
^j::WindowManager().MoveDown(Mouse.BigMove)
^l::WindowManager().MoveRight(Mouse.BigMove)

s::WindowManager().DecreaseWidth(Mouse.MediumMove)
f::WindowManager().IncreaseHeight(Mouse.MediumMove)
d::WindowManager().DecreaseHeight(Mouse.MediumMove)
g::WindowManager().IncreaseWidth(Mouse.MediumMove)

+s::WindowManager().DecreaseWidth(Mouse.SmallMove)
+f::WindowManager().IncreaseHeight(Mouse.SmallMove)
+d::WindowManager().DecreaseHeight(Mouse.SmallMove)
+g::WindowManager().IncreaseWidth(Mouse.SmallMove)

^s::WindowManager().DecreaseWidth(Mouse.BigMove)
^f::WindowManager().IncreaseHeight(Mouse.BigMove)
^d::WindowManager().DecreaseHeight(Mouse.BigMove)
^g::WindowManager().IncreaseWidth(Mouse.BigMove)

1::WinMove(0,                     0,,, "A")
2::WinMove(Mouse.FarLeftX,        0,,, "A")
3::WinMove(Mouse.HighLeftX,       0,,, "A")
4::WinMove(Mouse.MiddleLeftX,     0,,, "A")
5::WinMove(Mouse.LowLeftX,        0,,, "A")
6::WinMove(Mouse.LessThanMiddleX, 0,,, "A")
7::WinMove(Mouse.MiddleX,         0,,, "A")
8::WinMove(Mouse.MoreThanMiddleX, 0,,, "A")
9::WinMove(Mouse.LowRightX,       0,,, "A")
0::WinMove(Mouse.MiddleRightX,    0,,, "A")

+1::WinMove(0,                     Mouse.MiddleY,,, "A")
+2::WinMove(Mouse.FarLeftX,        Mouse.MiddleY,,, "A")
+3::WinMove(Mouse.HighLeftX,       Mouse.MiddleY,,, "A")
+4::WinMove(Mouse.MiddleLeftX,     Mouse.MiddleY,,, "A")
+5::WinMove(Mouse.LowLeftX,        Mouse.MiddleY,,, "A")
+6::WinMove(Mouse.LessThanMiddleX, Mouse.MiddleY,,, "A")
+7::WinMove(Mouse.MiddleX,         Mouse.MiddleY,,, "A")
+8::WinMove(Mouse.MoreThanMiddleX, Mouse.MiddleY,,, "A")
+9::WinMove(Mouse.LowRightX,       Mouse.MiddleY,,, "A")
+0::WinMove(Mouse.MiddleRightX,    Mouse.MiddleY,,, "A")

^1::WinMove(0,                     Mouse.LowY,,, "A")
^2::WinMove(Mouse.FarLeftX,        Mouse.LowY,,, "A")
^3::WinMove(Mouse.HighLeftX,       Mouse.LowY,,, "A")
^4::WinMove(Mouse.MiddleLeftX,     Mouse.LowY,,, "A")
^5::WinMove(Mouse.LowLeftX,        Mouse.LowY,,, "A")
^6::WinMove(Mouse.LessThanMiddleX, Mouse.LowY,,, "A")
^7::WinMove(Mouse.MiddleX,         Mouse.LowY,,, "A")
^8::WinMove(Mouse.MoreThanMiddleX, Mouse.LowY,,, "A")
^9::WinMove(Mouse.LowRightX,       Mouse.LowY,,, "A")
^0::WinMove(Mouse.MiddleRightX,    Mouse.LowY,,, "A")

a::WindowManager().SetFullHeight()
q::WindowManager().SetHalfHeight()
w::WindowManager().SetHalfWidth()
e::WindowManager().SetFullWidth()

#HotIf Environment.VimMode

`::Environment.WindowManagerMode := !Environment.WindowManagerMode

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
2::MouseMove(Mouse.HighLeftX,       Mouse.MiddleY)
3::MouseMove(Mouse.MiddleLeftX,     Mouse.MiddleY)
4::MouseMove(Mouse.LowLeftX,        Mouse.MiddleY)
5::MouseMove(Mouse.LessThanMiddleX, Mouse.MiddleY)
6::MouseMove(Mouse.MoreThanMiddleX, Mouse.MiddleY)
7::MouseMove(Mouse.LowRightX,       Mouse.MiddleY)
8::MouseMove(Mouse.MiddleRightX,    Mouse.MiddleY)
9::MouseMove(Mouse.HighRightX,      Mouse.MiddleY)
0::MouseMove(Mouse.FarRightX,       Mouse.MiddleY)

+1::MouseMove(Mouse.FarLeftX,        Mouse.TopY)
+2::MouseMove(Mouse.HighLeftX,       Mouse.TopY)
+3::MouseMove(Mouse.MiddleLeftX,     Mouse.TopY)
+4::MouseMove(Mouse.LowLeftX,        Mouse.TopY)
+5::MouseMove(Mouse.LessThanMiddleX, Mouse.TopY)
+6::MouseMove(Mouse.MoreThanMiddleX, Mouse.TopY)
+7::MouseMove(Mouse.LowRightX,       Mouse.TopY)
+8::MouseMove(Mouse.MiddleRightX,    Mouse.TopY)
+9::MouseMove(Mouse.HighRightX,      Mouse.TopY)
+0::MouseMove(Mouse.FarRightX,       Mouse.TopY)

^1::MouseMove(Mouse.FarLeftX,        Mouse.BottomY)
^2::MouseMove(Mouse.HighLeftX,       Mouse.BottomY)
^3::MouseMove(Mouse.MiddleLeftX,     Mouse.BottomY)
^4::MouseMove(Mouse.LowLeftX,        Mouse.BottomY)
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

sc1A::Screenshot.Start()
+sc1A::Send("+{PrintScreen}")
!sc1A::Send("!{PrintScreen}")

F1::Counter.Decrement().Show()
F2::Counter.Increment().Show()
F3::Counter.Send()
F4::Counter.Send().Increment()
F5::Counter.Show()
F6::Counter.Reset().Show()
F7:: {
	Environment.VimMode := false
	input := CleanInputBox().WaitForInput()
	Environment.VimMode := true
	if !input {
		return
	}
	Counter.num := input
	Counter.Show()
}

-::return
=::return
sc1B::return
sc2B::return
sc27::return
sc28::return
sc35::return

#HotIf