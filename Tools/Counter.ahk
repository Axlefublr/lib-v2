#Include <Tools\Info>

class Counter {
	static num := 0

	static ShowNumber(newNum) {
		static currInfo := Info(newNum)
		currInfo := currInfo.ReplaceText(newNum)
	}

	static Increment() => (++this.num, this)
	static Decrement() => (--this.num, this)
	static Reset() => (this.num := 0, this)
	static Send() => (Send(this.num), this)
	static Show() => this.ShowNumber(this.num)
}
