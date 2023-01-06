#Include <Utils\CharGenerator>

class SoundPlayer {

   wavPath := unset
   aliases := []
   static aliasesPerAudio := 7

   __New(wavPath) {
      if !wavPath ~= "\.wav$"
         throw ValueError("The sound file has to be a .wav file", -1, Format('SoundPlayer("{1}")', wavPath))
      this.wavPath := wavPath
      this.__GenerateAliases()
      this.__RegisterSound()
   }

   __RegisterSound() {
      for index, alias in this.aliases {
         DllCall("winmm\mciSendStringW", "Str", Format('open waveaudio!"{1}" Alias {2}', this.wavPath, alias), "Str", "", "UInt", 0, "Ptr", 0)
      }
   }

   __GenerateAliases() {
      loop SoundPlayer.aliasesPerAudio
         aliases.Push(CharGenerator(2).GenerateCharacters(5))
   }
   
   __GetCurrAlias() {
      static aliasCounter := 0
      aliasCounter++
      if aliasCounter > 5
         aliasCounter := 1
      return this.aliases[aliasCounter]
   }

   Play() {
      DllCall("winmm\mciSendStringW", "Str", "play " this.alias, "Str", "", "UInt", 0, "Ptr", 0)
   }
}