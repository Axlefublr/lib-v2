#Include <ClipSend>
#Include <Info>

;Takes multiline text and turns every line into a key in an array
str_FormatTableToArray() {
   formatted := StrReplace(str_GetSelection(), "`r`n", '", "')	;replacing every newline with ", "
   return '"' formatted '"' ;adding the missing "" at the first and last index
}

str_RemoveLineComments() => RegexReplace(str_GetSelection(), 'm)(\s;.*)|(^;.*)')

str_GetSelection(keepClip := true, shouldCutInstead := false) {
   if keepClip
      prevClip := ClipboardAll()
   A_Clipboard := ""
   Send("^" shouldCutInstead ? "x" : "c")
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
   Info("Converted to json")
   return text
}

str_RemoveExtraJsonIndentation(toParse) {
   text_full := toParse
   text_lines := StrSplit(text_full, "`n")
   for key, value in text_lines {
      RegexMatch(value, '^[\t ]*"((\\t)+)', &MatchedTabs)

      if key = 1 {
         try {
            text_extraTabs := StrReplace(MatchedTabs[1], "\t", "\\t")
         } catch
            return text_full
      }

      text_lines[key] := RegexReplace(value, '^(\s*")' text_extraTabs, "$1")
   }

   text_full := ""
   for key, value in text_lines {
      text_full .= value "`n"
   }

   return text_full
}