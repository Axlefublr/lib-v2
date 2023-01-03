
class CharGenerator {

   static NumberRange    := [48, 57]
   static LowercaseRange := [65, 90]
   static UppercaseRange := [97, 122]

   static Ranges := [
      this.LowercaseRange,
      this.UppercaseRange,
      this.NumberRange
   ]

   /**
    * The higher the number, the more different types of characters will be in the random character(s)
    * Choose 1 for lowercase characters only
    * 2 for uppercase also
    * 3 for numbers as well
    * @type {Integer}
    */
   Complexity := unset

   /**
    * Use this class to generate a random character / a string of random characters
    * @param complexity *Integer* The higher the number, the more different types of characters will be in the random character(s)
    * Choose 1 for lowercase characters only
    * 2 for uppercase also
    * 3 for numbers as well
    * @throws {IndexError} if you specify a complexity range that doesn't exist
    */
   __New(complexity) {
      if complexity < 1 {
         throw IndexError("Please specify a natural positive number", -1, "CharGenerator(" complexity ")")
      } else if complexity > 3 {
         throw IndexError("Currently only three ranges are supported", -1, "CharGenerator(" complexity ")")
      }

      this.Complexity := complexity
   }

   GenerateCharacter() {
      if this.Complexity > 1
      return
   }

}