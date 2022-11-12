#Include <Paths>
#Include <Image>

Class Discord {
   static Emoji() => Send("^e")

   static Gif() => Send("^g")

   static React() => WaitClick(Paths.Ptf["react"])
   static Edit()  => WaitClick(Paths.Ptf["edit"])
   static Reply() => WaitClick(Paths.Ptf["reply"])

}
