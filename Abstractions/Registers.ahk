#Include <Abstractions\Text>
#Include <Utils\KeyChorder>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\String>

class Registers {

   /**
    * @param key ***String*** — The key of the register to get the path of
    * @returns {String} The path of the register of entered key
    */
   static GetPath(key) => Paths.Reg "\reg_" key ".txt"

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
      key := KeyChorder()
      path := this.GetPath(key)
      WriteFile(path)
   }

   static Write() {
      key := KeyChorder()
      path := this.GetPath(key)
      WriteFile(path, A_Clipboard)
   }

   static Paste() {
      key := KeyChorder()
      path := this.GetPath(key)
      content := ReadFile(path)
      ClipSend(content)
   }

   static Run() {
     key := KeyChorder()
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
      key := KeyChorder()
      path := this.GetPath(key)
      text := ReadFile(path)
      shorterRegisterContents := this.__FormatRegister(text)
      Infos(shorterRegisterContents)
   }

}
