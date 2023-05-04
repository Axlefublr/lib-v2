; No dependencies

; Extend your test class with this "interface", to be able to run all of its methods via RunAll()
class Testable {
	/**
	 * Runs all the methods of a class.
	 * They have to be not static to be ran.
	 * Written by @Micha-ohne-el (thanks!!!)
	 */
	RunAll() {
		for key in this.base.OwnProps() { 
			if this.HasMethod(key)
				this.%key%()
		}
	}
}