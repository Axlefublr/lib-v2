/**
* Keeps searching for an image until it finds it
* @param imageFile *String* The path to the image
* @param coordObj *Object* An optional object with x1,y1,x2,y2 properties to search for the image in
* @returns {Array} with found X and Y coordinates
*/
WaitUntilImage(imageFile, coordObj?) {
	var := 0
	if !IsSet(coordObj) {
		coordObj := {
			x1: 0,
			y1: 0,
			x2: A_ScreenWidth,
			y2: A_ScreenHeight,
		}
	}
	SetTimer(() => var := "timed out", -5000)
	While !var {
		var := ImageSearch(&imgX, &imgY, coordObj.x1, coordObj.y1, coordObj.x2, coordObj.y2, imageFile)
	}
	if var = "timed out" {
		return false
	}
	return [imgX, imgY]
}

/**
* Searches for an image until it finds it, and then controlclicks on it
* @param imageFile *String* The path to the image file
*/
WaitClick(imageFile) {
	coords := WaitUntilImage(imageFile)
	if !coords
		return false
	ControlClick("X" coords[1] " Y" coords[2], "A")
}

/**
* Change the transparency of the current window
* @param whatCrement *Integer* Specify a negative integer to increase transparency (lower number => lower visibility)
*/
TransAndProud(whatCrement) {
	howTrans := WinGetTransparent("A")

	if !howTrans
		howTrans := 255

	etgServer := howTrans + whatCrement

	Switch {
		Case etgServer >= 255: etgServer := "Off"
		Case etgServer <= 1: etgServer := 1
	}

	try WinSetTransparent(etgServer, "A")
}

/**
* Make the current window completely untransparent
*/
Cis() {
	try WinSetTransparent(255, "A")
}


/**
* Occupies the thread until a pixel relative to your mouse position changes color
* @param r_RelPos *Array* Specify an array of *String* relative coordinates to check for. Format: "-5 200" or "30, -55" (so either with, or without a comma in between the x and y coordinates, depending on what you like more)
* @param timeout *Integer* The amount of seconds until the function times out and returns false
* @returns {Boolean} returns true if the function successfully caught the pixel color change, false in all the other situations the function might fail
*/
WaitUntilPixChange_Relative(r_RelPos, timeout := 5) {
	MouseGetPos(&locX, &locY)
	initPix := []
	endPix := []
	time := A_TickCount

	for key, value in r_RelPos {
		if !RegexMatch(value, "(-?\d+),? (-?\d+)", &init_coords)
			return false
		initPix.Push(PixelGetColor(locX + init_coords[1], locY + init_coords[2]))
	}

	Loop {
		for key, value in r_RelPos {
			if !RegexMatch(value, "(-?\d*),? (-?\d*)", &end_coords)
				return false
			endPix.Push(PixelGetColor(locX + end_coords[1], locY + end_coords[2]))
		}
		for key, value in initPix {
			if value != endPix[key]
				break 2
		}
		endPix := []
		if A_TickCount - time > timeout * 1000
			return false
	}
	return true
}

/**
* Waits for a change in color, on a place of the screen you specify
* @param coords *Array* The first value is x, the second value is y. Both absolute (not window / client)
* @param timeout *Integer* Amount of milliseconds, after which the function returns false
* @returns {Boolean} True if succeeded, False if timed out
*/
WaitUntilPixChange(coords := [], timeout := 5000) {
	if !coords.Length {
		throw UnsetError("You specified an empty array.`nExpected: An array with the x and y coordinates", -1, "coords - first parameter")
	}
	CoordMode("Pixel", "Screen")
	pixelColor := PixelGetColor(coords[1], coords[2])
	time := A_TickCount
	Loop {
		differentPixel := PixelGetColor(coords[1], coords[2])
		if A_TickCount - time = timeout
			return false
	} Until differentPixel != pixelColor
	return true
}

GetCurrentColor() {
	CoordMode("Mouse", "Screen")
	MouseGetPos(&x, &y)
	return PixelGetColor(x, y)
}