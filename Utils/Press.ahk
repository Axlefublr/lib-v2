;No dependencies

class Press {

	/**
	* Figure out what section of the screen your mouse is or isn't
	* @returns {Object} With properties: right, left, down, up, topRight, topLeft, bottomRight, bottomLeft, middle.
	* All of them are booleans which are true if your mouse cursor is in that part of the screen, and false if it isn't
	* Multiple properties can be true at once.
	*/
	static GetSections() {
		CoordMode("Mouse", "Screen")
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

}
