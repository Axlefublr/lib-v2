;No dependencies

class Press {

	/**
	 * 0.20
	 * @type {Float}
	 */
	static LongHoldDuration := 0.20

	/**
	 * Figure out what section of the screen your mouse is or isn't
	 * @returns {Object} With properties: right, left, down, up, topRight, topLeft, bottomRight, bottomLeft, middle.
	 * All of them are booleans which are true if your mouse cursor is in that part of the screen, and false if it isn't
	 * Multiple properties can be true at once.
	 */
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

	/**
	 * Do different actions depending on whether your mouse position is in a section of the screen, or not
	 * @param whichSection *String* The name of the section. The sections available are: left, right, up, down, topLeft, topRight, bottomLeft, bottomRight, middle.
	 * @param ifSection *Function object* The action to do if your mouse is in the specified section
	 * @param ifNotSection *Function object* The action to do if your mouse is not in the specified section
	 * @throws {ValueError} If whichSection is not a section name that exists
	 * @throws {TypeError} If either ifSection or ifNotSection are not function objects. Arrow function function objects, no parenthesis function objects, and bound functions are supported.
	 * @returns {Boolean} True if your mouse was inside of the specified section, false if not
	 */
	static ActOnSection(whichSection, ifSection, ifNotSection) {
		sections := this.GetSections()

		if !sections.HasProp(whichSection) {
			throw ValueError(Format('There is no section "{1}"', whichSection), -1, Format('Press.ActOnSection("{1}", ...)', whichSection))
		}

		static errorMesage := "Both ifSection and ifNotSection have to be function objects / bound functions."

		ifSectionType := Type(ifSection)
		ifNotSectionType := Type(ifNotSection)

		try ifSectionString := String(ifSection)
		catch {
			ifSectionString := ""
		}
		if !(ifSectionType ~= "Func|BoundFunc") {
			throw TypeError(errorMesage "`nifSection is a " ifSectionType " instead", -1, Format(
				'Press.ActOnSection(..., "{1}" , ...)', ifSectionString
			))
		}

		try ifNotSectionString := String(ifNotSection)
		catch {
			ifNotSectionString := ""
		}
		if !(ifNotSectionType ~= "Func|BoundFunc") {
			throw TypeError(errorMesage "`nifSection is a " ifNotSectionType " instead", -1, Format( 
				'Press.ActOnSection(..., ..., "{1}")', ifNotSectionString
			))
		}
		
		if sections.%whichSection% {
			ifNotSection()
			return false
		} else {
			ifSection()
			return true
		}
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
