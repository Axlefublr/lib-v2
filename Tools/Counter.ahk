class Counter {
   static num := 0
   static currInfo := 0

   static CloseInfo() {
      try {
         Win.Close(this.currInfo)
         WinWaitClose(this.currInfo)
      }
   }
   static Increment() {
      this.CloseInfo()
      this.currInfo := Info(++this.num)
   }
   static Decrement() {
      this.CloseInfo()
      this.currInfo := Info(--this.num)
   }
   static Reset() {
      this.CloseInfo()
      this.currInfo := Info(this.num := 0)
   }
   static Send() {
      this.CloseInfo()
      Send(this.num)
   }
   static Show() {
      this.CloseInfo()
      this.currInfo := Info(this.num)
   }
}