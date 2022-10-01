#Include <Win>
#Include <Gui>

/**
 * Shows a gui displaying text passed.
 * Click on the text to destroy the gui, or escape to destroy the oldest one.
 * The Infos() gui will appear in the first available space on the left,
 * starting from the top of the screen.
 * @param text *String*
 * @param autoCloseTimeout *Integer* Specify the amount of milliseconds after which
 * the Info is automatically destroyed.
 * No timeout by default (see the Info syntax sugar function below)
 */
Infos(text, autoCloseTimeout := 0) {
   static fontSize ; := 15
   /**
    * Assign a font size you'd like more. 20 by default
    * fontSize is not a parameter, because this would break the positioning of the guis
    * and decrease performance (probably the whole function to be fair)
    * So, pick what you'd rather have: more infos at a time or better visibility
    * Tested with font sizes: 5, 10, 15, 20, 25, 50, 100 - so you can feel free to pick any font size
    * and it should work
    */
   g_Info := Gui("AlwaysOnTop -caption").DarkMode(fontSize?)
   g_Info_text := g_Info.AddText(, text)
   static guiWidth := g_Info.MarginY * 5
   static maximumInfos := Floor(A_ScreenHeight / guiWidth)

   static AvailablePlaces := Map()
   static ranOnce := false
   if !ranOnce { ;I wish we could just `static loop`
      index := 0
      loop maximumInfos {
         index++
         AvailablePlaces.Set(index * guiWidth - guiWidth, false)
         /**
          * The keys of the map are the y coordinates where an info could be
          * The values start out being false, become true later when you call an info
          * This is useful, because you when you close an info by clicking on it,
          * That spot becomes available
          */
      }
      ranOnce := true
   }

   for key, value in AvailablePlaces {
      if value ;We look for a free spot, if it's true, it's taken, so we skip
         continue
      currYCoord := key
      AvailablePlaces[key] := true
      break
      ;If value isn't true (is false), then we found the free spot so we break out of the loop
   }

   if !IsSet(currYCoord) { ;If all values were true, we never set currYCoord, so it's unset...
      g_Info.Destroy()
      return ;...Since there are no spaces available, we return out of the function and do nothing after
   }

   Destruction(gui_hwnd_passed, currYCoord_passed, *) {
      /**
       * Passing the first two parameters might not be necessary, since they are just local variables
       * But with hotkeys and onevents for function that run many times, I've seen stuff work less
       * reliably when it's not actually binded and passed into the function, so this is a potentially
       * unnecessary but safe way to do what I want
       */
      HotIfWinExist("ahk_id " gui_hwnd_passed)
      Hotkey("Escape", "Off")
      win_Close(gui_hwnd_passed) ;Should be faster than WinClose, at least was in my previous version of Infos()
      AvailablePlaces[currYCoord_passed] := false ;The spot is no longer taken and can be used by the next Infos()
   }

   HotIfWinExist("ahk_id " g_Info.Hwnd)
   /**
    * Thanks to context specificity, escape held continuously keeps closing Infos from the oldest one
    * to the newest one
    * And since it's id specific, it won't ever overwrite another escape hotkey (will work over it though, probably)
    * And while a worse practice, you don't even need to disable it (which is what I do in Destruction)
    * since once the info gui doesn't exist, the escape hotkey won't be used by the function
    * Still, better to disable it, for I think performance 🤔
    */
   Hotkey("Escape", Destruction.Bind(g_Info.Hwnd, currYCoord), "On")
   g_Info_text.OnEvent("Click", Destruction.Bind(g_Info.Hwnd, currYCoord))
   if autoCloseTimeout {
      SetTimer(Destruction.Bind(g_Info.Hwnd, currYCoord), -autoCloseTimeout)
   }
   /**
    * This is the cream of the function and what I rewrote it for
    * I click on an info I no longer need, and that space becomes available for the next Info called
    * That way you can use all the space you have without spaces in between
    */
   g_Info.Show("AutoSize NA x0 y" currYCoord)
}

/**
 * Syntax sugar for Infos().
 * Instead of having to specify a timeout every time you want an autoclosing Info,
 * just use this function to make an Infos() that times out in 2 seconds
 * @param text *String*
 * @param timeout *Integer*
 */
Info(text, timeout?) => Infos(text, timeout ?? 2000)

ToggleInfo(text) {
   g_ToggleInfo := Gui("AlwaysOnTop -caption").DarkMode()
   g_ToggleInfo.Add("Text",, text)
   g_ToggleInfo.Show("W225 NA x1595 y640")
   SetTimer(() => g_ToggleInfo.Destroy(), -1000)
   return g_ToggleInfo
}