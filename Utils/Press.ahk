;No dependencies

class Press {

   /**
    * 0.20
    * @type {Float}
    */
   static LongHoldDuration := 0.20
   
   static GetSections() {
      MouseGetPos &sectionX, &sectionY
      right         := (sectionX > 1368)
      , left        := (sectionX < 568)
      , down        := (sectionY > 747)
      , up          := (sectionY < 347)
      , topRight    := ((sectionX > 1707) && (sectionY < 233))
      , topLeft     := ((sectionX < 252) && (sectionY < 229))
      , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
      , bottomRight := ((sectionX > 1673) && (sectionY > 839))
      , middle      := !right && !left && !down && !up

      return {
         right:       right,
         left:        left,
         down:        down,
         up:          up,
         topRight:    topRight,
         topLeft:     topLeft,
         bottomLeft:  bottomLeft,
         bottomRight: bottomRight,
         middle:      middle
      }
   }

   static ActOnSection(whichSection, ifSection, ifNotSection) {
      sections := this.GetSections()
      if !sections.HasProp(whichSection) {
         throw 
      }
   }
   
   ifTopLeft_Sugar(funcObj1, funcObj2, topLeftX := 250, topLeftY := 230) {
      MouseGetPos(&sectionX, &sectionY)
      topLeft := ((sectionX < topLeftX) && (sectionY < topLeftY))
      if topLeft
         funcObj2()
      else
         funcObj1()
   }

   /**
    * Format the A_ThisHotkey to a format useble for KeyWait.
    * CapsLock & f => f.
    * +!d => d.
    * @returns {String}
    */
   static FormatThisHotkey() {
      thisHotkey := A_ThisHotkey
      thisHotkey := RegexReplace(thisHotkey, "^.* & ", "", &isAndedHotkey)
      if !isAndedHotkey
         thisHotkey := RegexReplace(thisHotkey, "[#!^+<>*~$]|(?i:[\t ]+up)", "")
      return thisHotkey
   }

   /**
    * Figure out whether you held or tapped the current hotkey.
    * @param howLong *Float* How much time in seconds is considered a hold
    * @returns {Boolean} True if you held the key, false if you tapped it
    */
   static Hold(howLong := this.LongHoldDuration) => !KeyWait(this.FormatThisHotkey(), "U T" howLong)

   /**
    * Same as Press.Hold, but you can specify the function objects that get executed right in the function arguments.
    * @param tapFuncObj *Function object*
    * @param holdFuncObj *Function object*
    */
   static Hold_Sugar(tapFuncObj, holdFuncObj, howLong := this.LongHoldDuration) {
      if KeyWait(this.FormatThisHotkey(), "U T" howLong)
         tapFuncObj()
      else
         holdFuncObj()
   }

}
