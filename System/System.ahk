#Include <Paths>

class System {

	static Reboot() => Shutdown(2)

	static PowerDown() => Shutdown(1)

	static PowerDownSafely() => Run(Paths.Apps["Slide to shutdown"])

}