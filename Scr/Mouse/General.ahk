#Include <Utils\Press>
#Include <Utils\Win>
#Include <Other>
#Include <Abstractions\Base>

#MaxThreadsBuffer true

XButton1 & Media_Stop:: {
   sections := GetSections()
   Switch {
      case sections.up:   Win.Maximize()
      case sections.down: Win.RestoreDown()
   }
}

XButton2:: {
   sections := GetSections()
   Switch {
      Case sections.right: Send("{Media_Next}")
      Case sections.left: Send("{Media_Prev}")
      Case sections.down:CloseButActually()
      Case sections.up:Win.Minimize()
      Default:Paste()
   }
}

#MaxThreadsBuffer false