#Include <ClipSend>
#Include <Tools\Info>

str_GetSelection(keepClip := true, shouldCutInstead := false) {
   if keepClip
      prevClip := ClipboardAll()
   A_Clipboard := ""
   Send("^" (shouldCutInstead ? "x" : "{Insert}"))
   ClipWait(3, 1)
   selection := A_Clipboard
   if keepClip
      A_Clipboard := prevClip
   return selection
}

str_FormatSelection(formatting) {

   selection := str_GetSelection()

   Switch formatting, false {
      Case "title": selection := StrTitle(selection)
      Case "upper": selection := StrUpper(selection)
      Case "lower": selection := StrLower(selection)
   }

   ClipSend(selection, "")
}