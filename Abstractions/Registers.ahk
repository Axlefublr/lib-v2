#Include <Abstractions\Text>
#Include <Utils\KeyChorder>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\String>

class Registers {

   /**
    * The directory where you keep all of your register files.
    * Format: C:\Programming\registers
    * @type {String}
    */
   static RegistersDirectory := Paths.Reg

   /**
    * A string of characters that are accepted as register names.
    * Every register is just a file that has the character in its name.
    * Consider whether a character you want to add to this string would be allowed in a filename.
    * Case sensitive.
    * @type {String}
    */
   static ValidRegisters := "1234567890qwertyuiopasdfghjklzxcvbnm"

   /**
    * The maximum amount of characters shown when Peeking a register
    * @type {Integer}
    */
   static MaxPeekCharacters := 100

   /**
    * @param key ***String*** — The key of the register to get the path of
    * @returns {String} The path of the register of entered key
    */
   static GetPath(key) => this.RegistersDirectory "\reg_" key ".txt"

   static Read(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      return this.__TryGetRegisterText()
   }

   /**
    * @param key ***Char***
    * @private
    * @throws {ValueError} If the key passed isn't in Registers.ValidRegisters
    */
   static __ValidateKey(key) {
      if !InStr(this.ValidRegisters, key, true) {
         throw ValueError("
         (
            The key you passed isn't supported by Registers.
            Add it to the Registers.ValidRegisters string if you want to use it.
            Some keys aren't going to work even if you do.
         )", -2, key)
      }
      return key
   }

   /**
    * @param path ***String*** — To the register
    * @private
    * @returns {String} Text in the register. Empty string if the register doesn't exist.
    */
   static __TryGetRegisterText(path) {
      if FileExist(path)
         text := ReadFile(path)
      else
         text := ""
      return text
   }

   /**
    * @param text ***String***
    * @private
    * @returns {String} Up to first 100 characters in a file, where newlines are replaced by `\n`
    */
   static __FormatRegister(text) {
      registerContentsNoNewlines := text.RegExReplace("\r?\n", "\n")
      return registerContentsNoNewlines[1, this.MaxPeekCharacters]
   }

   /**
    * @param fileName ***String*** — Format: "reg_k.txt"
    * @private
    * @returns {String} The character of a register file. "reg_k.txt" => "k"
    */
   static __FormatRegisterName(fileName) {
      fileName := fileName.Replace("reg_")
      return fileName.Replace(".txt")
   }

   /**
    * Remove the contents of a register
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Truncate(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      WriteFile(path)
   }

   /**
    * Write the contents of your clipboard to a register
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Write(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      WriteFile(path, A_Clipboard)
   }

   /**
    * Paste the contents of a register
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Paste(key) {
      content := this.Read(key)
      ClipSend(content)
   }

   /**
    * Run the contents of a register with the Run() function
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Run(key) {
      command := this.Read(key)
      Run(command)
   }

   /**
    * Get an info for every register that is not empty.
    * Each info will display the name of the register and its contents.
    * In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
    * (configurable by modifying Registers.MaxPeekCharacters)
    */
   static PeekNonEmpty() {
      loop files this.RegistersDirectory "\*.txt" {
         text := ReadFile(A_LoopFileFullPath)
         if !text {
            continue
         }
         shorterRegisterContents := this.__FormatRegister(text)
         Infos(this.__FormatRegisterName(A_LoopFileName) ": " shorterRegisterContents)
      }
   }

   /**
    * Show the contents of a register in an info.
    * In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
    * (configurable by modifying Registers.MaxPeekCharacters)
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Peek(key) {
      text := this.Read(key)
      shorterRegisterContents := this.__FormatRegister(text)
      Infos(shorterRegisterContents)
   }

   /**
    * Show the full contents of a register in an info.
    * If you call this function multiple times without destroying the infos, they will overlap.
    * @param key ***Char*** — Register key
    * @throws {ValueError} If you pass an unsupported key
    */
   static Look(key) {
      text := this.Read(key)
      Infos(text)
   }

   /**
    * Move the contents of one register into another register
    * @param key1 ***Char*** — Register to move from
    * @param key2 ***Char*** — Register to move to
    * @throws {ValueError} If you pass an unsupported key
    */
   static Move(key1, key2) {
      this.__ValidateKey(key1)
      this.__ValidateKey(key2)

      path1 := this.GetPath(key1)
      path2 := this.GetPath(key2)

      WriteFile(path2, this.__TryGetRegisterText(path1))
      WriteFile(path1)
   }

}
