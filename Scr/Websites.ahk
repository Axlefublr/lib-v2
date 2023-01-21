#Include <Abstractions\Global>
#Include <Utils\KeyChorder>
#Include <App\Browser>
#Include <Loaders\Links>

#n:: {
   key := KeyChorder()
   static actions := Map(

      "m", () => RunLink(Links["gmail"]),
      "n", () => Browser.MonkeyType.winObj.App(),
      "g", () => RunLink(Links["ghm"]),
      "f", () => RunLink(Links["sf"]),
      "p", () => RunLink(Links["gpt"]),
      "r", () => RunLink(Links["regex"]),

   )
   try actions[key].Call()
}