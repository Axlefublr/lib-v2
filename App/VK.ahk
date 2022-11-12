Class VK {
   
   static winTitle := "Messenger ahk_exe chrome.exe"
   
   static Voice() => ControlClick("X1757 Y1014")
   
   static Scroll() => ControlClick("X1750 Y903")
   
   static Reply() => WaitClick(Paths.Ptf["vk reply"])
}
