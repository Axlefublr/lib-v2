#Include <ClipSend>
#Include <Info>
#Include <String>

;Takes multiline text and turns every line into a key in an array
str_FormatTableToArray() {
   formatted := StrReplace(str_GetSelection(), "`r`n", '", "')	;replacing every newline with ", "
   return '"' formatted '"' ;adding the missing "" at the first and last index
}

str_RemoveLineComments() {
   return RegexReplace(str_GetSelection(), 'm)(\s;.*)|(^;.*)')
}

str_GetSelection_Length() => str_GetSelection().Length

str_GetSelection(keepClip := true) {
   if keepClip
      prevClip := ClipboardAll()
   A_Clipboard := ""
   Send("^c")
   ClipWait(3, 1)
   selection := A_Clipboard
   if keepClip
      A_Clipboard := prevClip
   return selection
}

str_GetSelection_Cut(keepClip := true) {
   if keepClip
      prevClip := ClipboardAll()
   A_Clipboard := ""
   Send("^c")
   ClipWait(3, 1)
   , selection := A_Clipboard
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

str_ConvertToJson(IndentDepth := 10, TabLength := 3) {
   text := str_GetSelection()
   text := RegexReplace(text, '(["\\])', "\$1")
   text := RegexReplace(text, "(\r?\n)", '",$1')

   While IndentDepth > 0 {
      tabbies := ""
      Loop IndentDepth
         tabbies .= "\t"
      text := RegexReplace(text, "m)^\t{" IndentDepth "}", tabbies)
      text := RegexReplace(text, "m)^ {" IndentDepth * TabLength "}", tabbies)
      IndentDepth--
   }

   text := RegexReplace(text, "m)^", '"')
   A_Clipboard := text
   Info("Converted to json")
}

str_RemoveExtraJsonIndentation(toParse) {
   Text := {}
   Text.Full := toParse
   Text.Lines := StrSplit(Text.Full, "`n")
   for key, value in Text.Lines {
      RegexMatch(value, '^[\t ]*"((\\t)+)', &MatchedTabs)

      if key = 1 {
         try {
            Text.ExtraTabs := StrReplace(MatchedTabs[1], "\t", "\\t")
         } catch
            return Text.Full
      }

      Text.Lines[key] := RegexReplace(value, '^(\s*")' . Text.ExtraTabs, "$1")
   }

   Text.Full := ""
   for key, value in Text.Lines {
      Text.Full .= value "`n"
   }

   return Text.Full
}