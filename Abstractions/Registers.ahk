#Include <Abstractions\Text>
#Include <Utils\KeyChorder>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\String>

class Registers {

   static ValidRegisters := "1234567890qwertyuiopasdfghjklzxcvbnm"

   /**
    * @param key ***String*** — The key of the register to get the path of
    * @returns {String} The path of the register of entered key
    */
   static GetPath(key) => Paths.Reg "\reg_" key ".txt"

   static GetValidKeychord() {
      key := KeyChorder()
      if !InStr(this.ValidRegisters, key, true) {
         throw ValueError("The key you pressed isn't supported by Registers", -2, key)
      }
      return key
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
    * @param fileName ***String*** — reg_k.txt
    * @private
    * @returns {String} The character of a register file. "reg_k.txt" => "k"
    */
   static __FormatRegisterName(fileName) {
      fileName := fileName.Replace("reg_")
      return fileName.Replace(".txt")
   }

   static Truncate() {
      key := this.GetValidKeychord()
      path := this.GetPath(key)
      WriteFile(path)
   }

   static Write() {
      key := this.GetValidKeychord()
      path := this.GetPath(key)
      WriteFile(path, A_Clipboard)
   }

   static Paste() {
      key := this.GetValidKeychord()
      path := this.GetPath(key)
      content := ReadFile(path)
      ClipSend(content)
   }

   static Run() {
     key := this.GetValidKeychord()
     path := this.GetPath(key)
     command := ReadFile(path)
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

   static Peek() {
      key := this.GetValidKeychord()
      path := this.GetPath(key)
      text := ReadFile(path)
      shorterRegisterContents := this.__FormatRegister(text)
      Infos(shorterRegisterContents)
   }

   static Move() {
      key1 := this.GetValidKeychord()
      key2 := this.GetValidKeychord()

      path1 := this.GetPath(key1)
      path2 := this.GetPath(key2)

      WriteFile(path2, ReadFile(path1))
      WriteFile(path1)
   }

}
