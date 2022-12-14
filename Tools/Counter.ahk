#Include <Tools\Info>

class Counter {
   static num := 0

   static ShowNumber(newNum) {
      static currInfo := Info(newNum)
      currInfo := currInfo.ReplaceText(newNum)
   }
   static Increment() => this.ShowNumber(++this.num)
   static Decrement() => this.ShowNumber(--this.num)
   static Reset() => this.ShowNumber(this.num := 0)
   static Send() => Send(this.num)
   static Show() => this.ShowNumber(this.num)
}
