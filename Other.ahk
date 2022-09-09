#Include <Win>

Googler(searchRequest) {
   searchRequest := StrReplace(searchRequest, "+", "%2B")
   searchRequest := StrReplace(searchRequest, " ", "+")
   RunLink("https://www.google.com/search?q=" searchRequest)
}

CloseButActually() {
   Switch {
      Case WinActive("ahk_exe Spotify.exe"): spotify_Close()
      Case WinActive("ahk_exe steam.exe"):
         win_Close()
         ProcessClose("steam.exe")
      Case WinActive("ahk_exe gimp-2.10.exe"):
         win_Close()
         closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left}{Enter}")
      Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
         win_Close()
         closeWindow := "Message ahk_exe Resolve.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left 2}{Enter}")
      Case WinActive("Telegram ahk_exe Telegram.exe"):
         telegram_pid := WinGetPID("Telegram ahk_exe Telegram.exe")
         win_Close()
         ProcessClose(telegram_pid)
      Default: win_Close()
   }
}

RadNum() => Random(1000000, 9999999)

GetRandomCommitMessage() {
   five_random_words := " "
   Loop 5 {
      five_random_words .= GetRandomWord("english") " "
   }

   return A_Now five_random_words
}

Skipper(time) => (
   time := Round(Eval(time) / 5),
   Send("{Right " time "}")
)

GetWeekDay(day) {
   static ONE_MONTH := 100000000
   if StrLen(day) = 1
      day := "0" day	;We need the leading zero in the YYYYMMDDHH24MISS format if it's a single digit
   date := A_YYYY A_MM day "112233"	;Everything after the day doesn't matter, since we're getting the weekday, 112233 for easy visibility
   if A_DD > day
      date += ONE_MONTH	;Because I don't need to know what *was* the weekday of a passed day, I'll almost always want to know of the day yet to come
   Info(FormatTime(date, "dddd"))
}

;Pass a weekday (string) to get its date (string). Shows the day with no month in an Info(). Both Mon and Monday work. If you input a non-existant weekday, will stop executing after checking the next 7 days, and will say there's an error in an Info()
GetDayFromWeekDay(weekDay) {
   date := A_Now
   i := 0
   Loop {
      i++
      date := DateAdd(date, 1, "Day")
      if i > 7 {
         Info("No such weekday!")
         return
      }
      if FormatTime(date, "dddd") = weekDay
         || FormatTime(date, "ddd") = weekDay
         break
   }
   Info(FormatTime(date, "d"))
}
