;No dependencies

/**
 * A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Retains your clipboard as well
 * @param toSend *String* The text you want to send
 * @param endChar *String* The ending character you want after the text you send
 * @param isClipReverted *Boolean* Set to false if you want the text sent to become your current clipboard
 * @param untilRevert *Integer* The time it takes for your clipboard to get reverted to what it was before calling the function
 */
ClipSend(toSend, endChar := "", isClipReverted := true, untilRevert := 200) {
   /*
      Because there's no way to know whether an application has received the input we sent it with ^v
      We revert the clipboard after a certain time (untilRevert)

      If we reverted the clipboard immidiately, we'd end up sending not "toSend", but the previous clipboard instead, because we didn't give the application enough time to process the action.

      This time depends on the app, discord seems to be one of the slowest ones (don't break TOS guys), but a safe time for untilRevert seems to be 50ms. This time might be lower or higher on your machine, configure as needed
    */
   if isClipReverted
      prevClip := ClipboardAll()	;We keep the previous clipboard

   A_Clipboard := ""	;We free the clipboard...
   A_Clipboard := toSend endChar	;Now the clipboard is what we want to send + and ending character. I often need a space after so I add a space by default, you can change what it is in the second parameter
   ClipWait(1)	;...so we can make sure we filled the clipboard with what we want before we send it
   Send("{Shift Down}{Insert}{Shift Up}")	;We send it. Not ^v because this variant is more consistent

   if isClipReverted
      SetTimer(() => A_Clipboard := prevClip, -untilRevert)	;We revert the clipboard in 50ms. This doesn't occupy the thread, so the clipsend itself doesn't take 50ms, only the revert of the clipboard does.
}
