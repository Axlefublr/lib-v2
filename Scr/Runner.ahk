#Include <Loaders\App>
#Include <Utils\ClipSend>
#Include <Loaders\Links>
#Include <Extensions\String>
#Include <Utils\Win>
#Include <Paths>
#Include <Utils\Char>
#Include <Loaders\Tools>
#Include <Abstractions\Script>
#Include <Abstractions\Global>
#Include <Other>
#Include <Converters\DateTime>
#Include <Tools\CleanInputBox>
#Include <App\Slack>

+!l:: {
   if !input := CleanInputBox().WaitForInput() {
      return false
   }

   static runner_commands := Map(

      "update",  () => GitHub.UpdateAhkLibraries(),
      "str len", () => Infos(A_Clipboard.Length),
      "shows",   () => Shows().GetList(),
      "rel",     () => Reload(),
      "track",   () => ClipSend(Spotify.GetCurrSong(),, false),
      "kb",      () => KeyCodeGetter(),
      "eat",     () => EatingLogger(),
      "libs?",   () => Infos(CountLibraries()),

      ;Apps
      "sm",      Run.Bind(Paths.Apps["Sound mixer"]),
      "apps",    MainApps,
      "v1 docs", () => Autohotkey.Docs.v1.RunAct(),
      "davinci", () => Davinci.projectWinObj.RunAct(),
      "slack",   () => Slack.winObj.RunAct(),
      "steam",   () => Steam.winObj.RunAct(),
      "vpn",     () => VPN.winObj.RunAct(),
      "fl",      () => FL.winObj.RunAct(),
      "ds4",     () => DS4.winObj.RunAct(),
      "gimp",    () => Gimp.winObj.RunAct(),
      "mt",      () => Browser.MonkeyType.winObj.RunAct(),

      ;Folders
      "ext",   () => Explorer.WinObj.VsCodeExtensions.RunAct_Folders(),
      "prog",  () => Explorer.WinObj.Prog.RunAct_Folders(),
      "saved", () => Explorer.WinObj.SavedScreenshots.RunAct_Folders(),
      "gim",   () => Explorer.WinObj.VideoTools.RunAct_Folders(),
      "main",  () => VsCode.WorkSpace("Main"),

      ;Video production
      "clean",    () => VsCode.CleanText(ReadFile(A_Clipboard)),
      "edit",     () => Video.EditScreenshot(),
      "video up", () => VsCode.VideoUp(),
      "dupl",     () => Video.DuplicateScreenshot(),
      "setup",    () => Davinci.Setup(),
      "cut",      () => LosslessCut.winObj.RunAct(),

   )

   try runner_commands[input].Call()
   catch Any {
      RegexMatch(input, "^(p|o|s|r|t|a|ev|i|show|link|ep|delow|counter|gl|go|install|chrs|dd|down|drop|disc|sy|ts|evp|cp|tm|glo) (.+)", &result)
      static runner_regex := Map(

         "p",       (input) => ClipSend(Links[input], , false),
         "o",       (input) => RunLink(Links[input]),
         "cp",      (input) => A_Clipboard := input,
         "s",       (input) => SoundPlay(Paths.Sounds "\" input ".mp3"),
         "r",       (input) => Spotify.NewRapper(input),
         "t",       (input) => Timer(input).Start(),
         "tm",      (input) => (
            timerObj := Timer(input),
            timerObj.shouldRing := false,
            timerObj.Start()
         ),
         "a",       (input) => Spotify.FavRapper_Manual(input),
         "ev",      (input) => Infos(Calculator(input)),
         "evp",     (input) => ClipSend(Calculator(input)),
         "i",       (input) => Infos(input),
         "show",    (input) => Shows().Run(input),
         "down",    (input) => Shows().Run(input, "downloaded"),
         "link",    (input) => Shows().SetLink(input),
         "ep",      (input) => Shows().SetEpisode(input),
         "dd",      (input) => Shows().SetDownloaded(input),
         "delow",   (input) => Shows().DeleteShow(input),
         "drop",    (input) => Shows().DeleteShow(input, true),
         "counter", (input) => Info(Counter.num := input),
         "gl",      (input) => ClipSend(Git.Link(input), "", false),
         "go",      (input) => RunLink(Git.Link(input)),
         "glo",     (input) => (
            link := Git.Link(input),
            RunLink(link),
            A_Clipboard := link
         ),
         "install", (input) => Git.InstallAhkLibrary(input),
         "chrs",    (input) => ClipSend(CharGenerator(2).GenerateCharacters(input)),
         "disc",    (input) => Spotify.NewDiscovery_Manual(input),
         "sy",      (input) => Symbol(input),

      )
      try runner_regex[result[1]].Call(result[2])
   }
}

#Hotstring EndChars `t

#m:: {
   input := CleanInputBox().WaitForInput()
   if !input {
      return
   }
   static DynamicHotstrings := Map(

      "radnum",    () => RadNum(),
      "date",      () => DateTime.Date,
      "datew",     () => DateTime.WeekDay,
      "time",      () => DateTime.Time,
      "datetime",  () => DateTime.Date " " DateTime.Time,
      "datewtime", () => DateTime.Date " " DateTime.WeekDay " " DateTime.Time,
      "uclanr",    () => GetRandomWord("english") " ",
      "ilandh",    () => GetRandomWord("russian") " ",
      "chrs",      () => CharGenerator(2).GenerateCharacters(15),

   )
   static StaticHotstrings := Map(

      "gh",    Links["gh"],
      "ghm",   Links["ghm"],
      "micha", "Micha-ohne-el",
      "reiwa", "rbstrachan",
      "me",    "Axlefublr",

   )
   try {
      output := DynamicHotstrings[input].Call()
   } catch Any {
      try output := StaticHotstrings[input]
      catch Any {
         return
      }
   }
   ClipSend(output)
}
