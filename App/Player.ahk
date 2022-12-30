Class Player {
   static exeTitle := "ahk_exe KMPlayer64.exe"
   static winTitle := this.exeTitle
   
   static winObj := Win({winTitles: [
      Spotify.exeTitle,
      Player.winTitle,
      "WatchMoviesHD " Browser.exeTitle,
      "Gogoanime " Browser.exeTitle
   ]})
}