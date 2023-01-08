;Made by @thqby (https://github.com/thqby), rewritten slightly into my style
#Include <External\Json>
Print(toPrint) {
   toPrint_string := ""
   switch Type(toPrint) {
      case "Map", "Array", "Object":
         toPrint_string := JSON.stringify(toPrint)
      default:
         try toPrint_string := String(toPrint)
   }
   try FileAppend(toPrint_string "`n", "*", "utf-8")
}