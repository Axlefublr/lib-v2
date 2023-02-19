#Include <Utils\Press>
#Include <Utils\Win>
#Include <Abstractions\Base>

#MaxThreadsBuffer true

XButton2:: {
    sections := Press.GetSections()
    Switch {
        Case sections.topRight:    Win.Maximize()
        Case sections.topLeft:     Win.RestoreDown()
        Case sections.bottomRight: Send("{Browser_Forward}")
        Case sections.bottomLeft:  Send("{Browser_Back}")
        Case sections.right:       Send("{Media_Next}")
        Case sections.left:        Send("{Media_Prev}")
        Case sections.down:        CloseButActually()
        Case sections.up:          Win.Minimize()
        Default:                   return
    }
}

#MaxThreadsBuffer false