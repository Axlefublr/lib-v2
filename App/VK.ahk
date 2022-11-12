Class VK {
   
   winTitle := "Messenger ahk_exe chrome.exe"
   
   Voice() => ControlClick("X1757 Y1014")
   
   Scroll() => ControlClick("X1750 Y903")
   
   Reply() => WaitClick(Paths.Ptf["vk reply"])
}
