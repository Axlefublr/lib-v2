#Include <Utils\Image>
#Include <Paths>
#Include <App\Git>

Class GitHub {

   static Profile() {
      ControlClick("x1825 y134")
      WaitClick(Paths.Ptf["github"])
   }

   static UpdateAhkLibraries() {
      Git.InstallAhkLibrary("https://github.com/Descolada/AHK-v2-libraries/blob/main/Lib/String.ahk")
      Git.InstallAhkLibrary("https://github.com/TheArkive/eval_ahk2/blob/master/_eval.ahk", "Eval.ahk")
   }

}