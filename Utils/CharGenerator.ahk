
class CharGenerator {

   ; static NumberRange := [48, 57]
   static LowercaseRange := [65, 90]
   static UppercaseRange := [97, 122]

   static Ranges := [
      this.LowercaseRange,
      this.UppercaseRange
      ; this.NumberRange
   ]
   
   static GetRandomSingleCase(charType) {
      charNum := Random(this.Ranges[charType][1], this.Ranges[charType][2])
      return Chr(TransfToHex(charNum))
   }
   
   static GetRandomSingleCaseMultiple(charType, amount) {
      str := ""
      loop amount {
         str .= this.GetRandomSingleCase(charType)
      }
      return str
   }
   
   static GetRandomAnyCase() {
      picker := Random(1, 2)
      this.GetRandom(picker)
   }
   
   static GetRandomAnyCaseMultiple(amount) {
      str := ""
      loop amount {
         charType := Random(1, 2)
         str .= this.GetRandomSingleCase(charType)
      }
   }
}