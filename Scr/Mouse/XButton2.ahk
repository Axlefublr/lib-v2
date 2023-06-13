#Include <Utils\Press>
#Include <Utils\Win>
#Include <Abstractions\Base>
#Include <App\Youtube>
#Include <App\Spotify>
#Include <Abstractions\MediaActions>
#Include <Misc\CloseButActually>
#Include <Abstractions\WindowManager>

XButton2::return
!XButton1:: {
	sections := Press.GetSections()
	Switch {
		Case sections.topRight:    WinMaximize("A")
		Case sections.topLeft:     WinRestore("A")
		Case sections.bottomRight: Send("{Browser_Forward}")
		Case sections.bottomLeft:  Send("{Browser_Back}")
		Case sections.down:        CloseButActually()
		Case sections.up:          WinMinimize("A")
		Case sections.right:       MediaActions.SkipNext()
		Case sections.left:        MediaActions.SkipPrev()
		Default:                   return
	}
}