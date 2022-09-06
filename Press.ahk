;No dependencies

A_ThisHotkey_Formatted() {
   thisHotkey := A_ThisHotkey
   thisHotkey := RegexReplace(thisHotkey, "^.* & ", "", &isAndedHotkey)
   if !isAndedHotkey
      thisHotkey := RegexReplace(thisHotkey, "[#!^+<>*~$]|(?i:[\t ]+up)", "")
   return thisHotkey
}

;For the sugar variants, funcObj1 is for a short one click, funcObj2 is for when you held / double pressed it, whatever else

press_Twice(howLong := 200) => (A_PriorHotkey = A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)

press_Twice_Sugar(funcObj1, funcObj2, howLong := 200) {
   if (A_PriorHotkey = A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)
      funcObj2()
   else
      funcObj1()
}

press_Double(howLong := "0.1") {
   KeyWait(A_ThisHotkey_Formatted(), "U")
   if KeyWait(A_ThisHotkey_Formatted(), "D T" howLong) {
      KeyWait(A_ThisHotkey_Formatted(), "U")	;If you don't, will first return false and then true from one double press
      return true
   } else
      return false
}

press_Double_Sugar(funcObj1, funcObj2, howLong := "0.1") {
   KeyWait(A_ThisHotkey_Formatted(), "U")
   if KeyWait(A_ThisHotkey_Formatted(), "D T" howLong) {
      KeyWait(A_ThisHotkey_Formatted(), "U")	;If you don't, will first return false and then true from one double press
      funcObj2()
   } else
      funcObj1()
}

press_Hold(howLong := 0.20) => !KeyWait(A_ThisHotkey_Formatted(), "U T" howLong)

press_Hold_Sugar(funcObj1, funcObj2, howLong := 0.20) {
   if KeyWait(A_ThisHotkey_Formatted(), "U T" howLong)
      funcObj1()
   else
      funcObj2()
}

ifTopLeft_Sugar(funcObj1, funcObj2, topLeftX := 250, topLeftY := 230) {
   MouseGetPos(&sectionX, &sectionY)
   topLeft := ((sectionX < topLeftX) && (sectionY < topLeftY))
   if topLeft
      funcObj2()
   else
      funcObj1()
}

ifTopLeftRight_Sugar(funcObj1, funcObj2, funcObj3, topLeftX := 250, topRightX := 1700, topY := 230) {
   MouseGetPos(&sectionX, &sectionY)
   topLeft := ((sectionX < topLeftX) && (sectionY < topY))
   topRight := ((sectionX > topRightX) && (sectionY < topY))
   Switch {
      Case topRight: funcObj3()
      Case topLeft: funcObj2()
      Default: funcObj1()
   }
}