#Include <Abstractions\Text>
#Include <Utils\KeyChorder>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\String>

class Registers {

   /**
    * A string of characters that are accepted as register names.
    * Every register is just a file that has the character in its name.
    * Consider whether a character you want to add to this string would be allowed in a filename.
    * Case sensitive.
    * @type {String}
    */
   static ValidRegisters := "1234567890qwertyuiopasdfghjklzxcvbnm"

   /**
    * @param key ***String*** — The key of the register to get the path of
    * @returns {String} The path of the register of entered key
    */
   static GetPath(key) => Paths.Reg "\reg_" key ".txt"

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
      return registerContentsNoNewlines[1, 100]
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

   static Truncate(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      WriteFile(path)
   }

   static Write(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      WriteFile(path, A_Clipboard)
   }

   static Paste(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      content := this.__TryGetRegisterText(path)
      ClipSend(content)
   }

   static Run(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      command := this.__TryGetRegisterText(path)
      Run(command)
   }

   static PeekNonEmpty() {
      loop files Paths.Reg "\*.txt" {
         text := ReadFile(A_LoopFileFullPath)
         if !text {
            continue
         }
         shorterRegisterContents := this.__FormatRegister(text)
         Infos(this.__FormatRegisterName(A_LoopFileName) ": " shorterRegisterContents)
      }
   }

   static Peek(key) {
      this.__ValidateKey(key)
      path := this.GetPath(key)
      text := this.__TryGetRegisterText(path)
      shorterRegisterContents := this.__FormatRegister(text)
      Infos(shorterRegisterContents)
   }

   static Move(key1, key2) {
      this.__ValidateKey(key1)
      this.__ValidateKey(key2)

      path1 := this.GetPath(key1)
      path2 := this.GetPath(key2)

      WriteFile(path2, this.__TryGetRegisterText(path1))
      WriteFile(path1)
   }

}
