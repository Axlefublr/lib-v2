#Include <Abstractions\Text>
#Include <Utils\KeyChorder>
#Include <Paths>
#Include <Tools\Info>
#Include <Extensions\String>

class Registers {

   static GetPath(key) => Paths.Reg "\reg_" key ".txt"

   static Overwrite() {
      key := KeyChorder()
      path := this.GetPath(key)
      WriteFile(path)
   }

   static __FormatRegister(text) {
      registerContentsNoNewlines := text.RegExReplace("\r?\n", "\n")
      return registerContentsNoNewlines[1, 100]
   }

   static __FormatRegisterName(fileName) {
      fileName := fileName.Replace("reg_")
      return fileName.Replace(".txt")
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

}