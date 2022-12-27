; No dependencies

class HoverScreenshot {

   picturePath := ""

   __New() {
      this.gHover := Gui("AlwaysOnTop +ToolWindow -Caption")
   }

   ; if !picturePath := FileSelect(, Paths.SavedScreenshots,, "*.png") {
   ;    return false
   ; }

   Show() {
      if !(this.picturePath ~= "^[A-Z]:\\") {
         HoverScreenshot.Exceptions.PicturePathWrong(this.picturePath)
      }
      this.gcPicture := this.gHover.AddPicture(, this.picturePath)
      WinSetTransColor(0xF0F0F0, this.gHover.Hwnd)

      this.gHover.Show("AutoSize NA")
   }

   ; gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
   ; gcPicture.OnEvent("Click",       (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())
   ; return true

   class Exceptions {
      static PicturePathWrong(picturePath) {
         throw MethodError("
            (
               You didn't set a picture path to show
               Use the "UseSecondToLast()" method to pick the second to last screenshot automatically
               Use the "SelectPath()" method to let the user pick the picture to show in a menu interactively
               Set the "picturePath" property manually if you have your own way of getting the path
            )",
            -2,
            "
            (
               picturePath property
               value:
            )" picturePath "`n" "
            (
               type:
            )" Type(picturePath)
         )
      }
   }
}