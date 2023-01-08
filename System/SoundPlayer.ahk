;No dependencies

class SoundPlayer {

   static Storage := Map()

   wavPath := unset

   __New(wavPath) {
      if !(wavPath ~= "\.wav$")
         throw ValueError("The sound file has to be a .wav file", -1, Format('SoundPlayer("{1}")', wavPath))
      this.wavPath := wavPath
      this.__RegisterSound()
   }

   __mciSend(command) => DllCall("winmm\mciSendStringW", "Str", command, "Str", "", "UInt", 0, "Ptr", 0)

   __RegisterSound() => this.__mciSend('open "' this.wavPath '" type waveaudio')

   Play() {
      this.__mciSend('play "' this.wavPath '" from 0')
   }

   __Delete() => this.__mciSend('close "' this.wavPath '"')
}
