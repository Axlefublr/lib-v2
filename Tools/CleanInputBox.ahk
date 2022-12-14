#Include <Gui>

; This is like a really long line that also wraps so I can show off the gj and gk. In case you didn't know I make videos about autohotkey v2 as well on this channel, subscribe if you're interested. Fun fact: the "Stay fresh, cheesebags!" at the end of my outtro comes from a meme.

Class CleanInputBox extends Gui {
   Width     := Round(A_ScreenWidth / 1920 * 1200)
   TopMargin := Round(A_ScreenHeight / 1080 * 200)

   /**
    * Get a gui to type into.
    * Close it by pressing Escape. (This exits the entire thread)
    * Accept your input by pressing Enter.
    * Call WaitForInput() after creating the class instance.
    */
   __New() {
      super.__New("AlwaysOnTop -Caption")
      this.DarkMode().MakeFontNicer(30)
      this.MarginX := 0

      this.InputField := this.AddEdit(
         "x0 Center -E0x200 Background"
         this.BackColor " w" this.Width
      )

      this.Input := ""
      this.isWaiting := true
      this.RegisterHotkeys()
      this.Show()
   }

   Show() => super.Show("y" this.TopMargin " w" this.Width)

   /**
    * Occupy the thread until you type in your input and press
    * Enter, returns this input
    * @returns {String}
    */
   WaitForInput() {
      while this.isWaiting {
      }
      return this.Input
   }

   SetInput() {
      this.Input := this.InputField.Text
      this.isWaiting := false
      this.Finish()
   }

   SetCancel() {
      this.isWaiting := false
      this.Finish()
   }

   RegisterHotkeys() {
      HotIfWinactive("ahk_id " this.Hwnd)
      Hotkey("Enter", (*) => this.SetInput(), "On")
      this.OnEvent("Escape", (*) => this.SetCancel())
   }

   Finish() {
      HotIfWinactive("ahk_id " this.Hwnd)
      Hotkey("Enter", "Off")
      this.Minimize()
      this.Destroy()
   }
}
