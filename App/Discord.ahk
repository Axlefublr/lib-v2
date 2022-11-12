#Include <Paths>
#Include <Image>

Class Discord {
   
   static winTitle  := "Discord ahk_exe Discord.exe"
   static exception := "Updater" ;Don't consider the window to be discord if it has this in its title
   
   static Emoji() => Send("^e")

   static Gif() => Send("^g")

   static React() => WaitClick(Paths.Ptf["react"])
   static Edit()  => WaitClick(Paths.Ptf["edit"])
   static Reply() => WaitClick(Paths.Ptf["reply"])

}
