class SoundPlayer {

   wavPath := unset
   alias := unset

   __New(wavPath) {
      this.wavPath := wavPath
   }

   __RegisterSound() {
      DllCall("winmm\mciSendStringW", "Str", Format('open waveaudio!"{1}" Alias {2}', this.wavPath, this.alias), "Str", "", "UInt", 0, "Ptr", 0)
   }

   __GenerateAlias() {

   }

   Play() {
      DllCall("winmm\mciSendStringW", "Str", "play " this.alias, "Str", "", "UInt", 0, "Ptr", 0)
   }
}