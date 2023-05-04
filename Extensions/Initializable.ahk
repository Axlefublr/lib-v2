; No dependencies

class Initializable {
	Initialize(argObj) {
		for property, value in argObj.OwnProps() {
			if this.HasProp(property) {
				this.%property% := value
				continue
			}
			throw PropertyError("Class doesn't define this property / field", -2, property)
		}
	}
}
