;No dependencies

/**
 * Play a wav sound
 */
class SoundPlayer {

	/**
	 * Use this map to store all of your SoundPlayer objects
	 * @type {Map}
	 */
	static Storage := Map()

	/**
	 * The full path to your sound, which has a .wav extension
	 * You can use this property to check the wavPath of the object
	 * But don't try to change it after you specify it in the constructor
	 * Because that won't work
	 * But if you *really* want to, call __Delete() before setting the property
	 * And __RegisterSound() after setting the property
	 * @type {String}
	 */
	wavPath := unset

	/**
	 * Play a wav sound by calling .Play() after initializing the class
	 * @param wavPath *String* the full path to your sound. 
	 * Will be available as a property once you create the class instance
	 * @throws {ValueError} if you pass a path that is not a .wav sound file
	 * @example <caption>of how to use this class to play a sound with a hotkey</caption>
	 * SoundPlayer.Storage.Set("name of my sound", "C:\Sounds\mysound.wav")
	 * F13::SoundPlayer.Storage["name of my sound"].Play()
	 */
	__New(wavPath) {
		if !(wavPath ~= "\.wav$")
			throw ValueError("The sound file has to be a .wav file", -1, Format('SoundPlayer("{1}")', wavPath))
		this.wavPath := wavPath
		this.__RegisterSound()
	}

	/**
	 * An abstraction to send the DllCall we need for this to work.
	 * Is functionally identical to just using that DllCall.
	 * @private
	 */
	__mciSend(command) => DllCall("winmm\mciSendStringW", "Str", command, "Str", "", "UInt", 0, "Ptr", 0)

	/**
	 * Before we can play a sound, we have to open the file of the sound
	 * @private
	 */
	__RegisterSound() => this.__mciSend('open "' this.wavPath '" type waveaudio')

	/**
	 * Play the sound of the specified wavPath
	 */
	Play() {
		this.__mciSend('play "' this.wavPath '" from 0')
	}

	/**
	 * Is called automatically once this class is garbage collected
	 * Same way we need to open a file before we play it, we need to close the file
	 * once we're done with it
	 * If you don't, windows won't let you delete or rename the file because it's opened
	 * in Autohotkey64.exe
	 * @private
	 */
	__Delete() => this.__mciSend('close "' this.wavPath '"')
}
