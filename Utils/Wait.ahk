; No dependencies

/**
 * A non thread taking sleep, essentially.
 * Pass a condition function object, to be executed as often as possible.
 * And an action function object, to be executed once the condition function object returns true.
 * @param {FuncObj} condition Evaluated every ~16ms. Once it's true, `action` is called.
 * @param {FuncObj} action Called once `condition` is true
 * @param {Integer} timeout Time in milliseconds, after which the settimer is deleted automatically, without calling `action`.
 * @param {Integer} oftenity I'm sorry I had to name it in this goofy way because it's very funny.
 * This parameter decides how often the check of `condition` happens, in ms.
 * If you pass 0 or a negative number, there's no timeout.
 */
Wait(condition, action, timeout := 0, oftenity := 1) {

	startTime := A_TickCount

	Check() {
		if !condition()
			return
		if timeout > 0 && A_TickCount - startTime >= timeout {
			SetTimer(, 0)
			return
		}
		action()
		SetTimer(, 0)
	}

	SetTimer(Check, oftenity)
}