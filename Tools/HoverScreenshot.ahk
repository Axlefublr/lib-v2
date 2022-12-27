#Include <Gui>

class HoverScreenshot {

   /**
    * Full path to the picture you want to hover (show).
    * @type {String}
    */
   picturePath := ""

   /**
    * The gui object
    * Will be set in the constructor of the class
    * @type {Gui}
    */
   gHover := unset

   /**
    * The guictrl object of the picture
    * Will be set after Show() is called on the class instance
    * @type {GuiCtrl}
    */
   gcPicture := unset

   __New() {
      this.gHover := Gui("AlwaysOnTop +ToolWindow -Caption")
   }

   /**
    * Sets the picturePath to the second to last screenshot you've taken.
    * This will generally work because every time you take a screenshot, two pictures appear in
    * your screenshots folder.
    * One is the actual screenshot you wanna show, the second being the picture that gets shown
    * in the notification after you take a screenshot.
    * By getting the second to last (by creation time) picture, we will usually get the actual
    * screenshot.
    * This is not stable: sometimes the actual screenshot will not be second to last,
    * but it is usually.
    * Use "SelectPath()" instead if you treasure stability over comfortability
    */
   UseSecondToLast() {
      previousTimeStamp := 0
      image1            := ""
      image2            := ""
      loop files Paths.SavedScreenshots "\*.png" {
         if A_LoopFileTimeCreated > previousTimeStamp {
            previousTimeStamp := A_LoopFileTimeCreated
            image2 := image1
            image1 := A_LoopFileFullPath
         }
      }
      this.picturePath := image2
   }

   /**
    * Brings up an interactive menu where the user can pick the picture to show
    * (sets the picturePath property).
    * Will always start in the folder where windows stores your Win+Shift+S screenshots,
    * filtering only pngs (since there are only pngs there).
    * You can still go and pick a picture from any other place, just make sure the format is
    * supported
    * @returns {Boolean} True if you picked something, false if you didn't
    */
   SelectPath() {
      picturePath := FileSelect(, Paths.SavedScreenshots,, "*.png")
      if picturePath {
         this.picturePath := picturePath
         return true
      }
      return false
   }

   /**
    * Shows the gui with the picture you set
    * Before calling this method, make sure you set the picturePath property to the path of the
    * picture you want to show
    * If you don't, this method will throw an error
    */
   Show() {
      if !(this.picturePath ~= "^[A-Z]:\\") {
         HoverScreenshot.Exceptions.PicturePathWrong(this.picturePath)
      }
      this.gcPicture := this.gHover.AddPicture(, this.picturePath)
      WinSetTransColor(0xF0F0F0, this.gHover.Hwnd)

      this.gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
      this.gcPicture.OnEvent("Click",       (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())

      this.gHover.Show("AutoSize NA")
   }

   class Exceptions {
      /**
       * Throw this if the picturePath property is not set / is not a path
       * @param picturePath pass the current picturePath to show in the error message
       */
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