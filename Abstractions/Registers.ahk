#Include <Paths> ; For you, this isn't required. For me, it is.
#Include <Abstractions\Text>
#Include <Tools\Info>
#Include <Extensions\String>
#Include <Utils\ClipSend>
#Include <Converters\Layouts>
#Include <Utils\Cmd>

class Registers {

	/**
	* Commands executed will note you of their completion.
	* Set up how long they should stay.
	* In milliseconds.
	* @type {Integer}
	*/
	static InfoTimeout := 500

	/**
	* The directory where you keep all of your register files.
	* Format: C:\Programming\registers
	* @type {String}
	*/
	static RegistersDirectory := Paths.Reg

	/**
	* A string of characters that are accepted as register names.
	* Every register is just a file that has the character in its name.
	* Consider whether a character you want to add to this string would be allowed in a filename.
	* Case sensitive.
	* @type {String}
	*/
	static ValidRegisters := "1234567890QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm"

	/**
	* I never want to accidentally write to a russian-named register, so there's a check
	* @type {String}
	*/
	static RussianCharacters := "йцукенгшщзхъфывапролджэячсмитьЙЦУКЕНГШЩЗФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"

	/**
	* The maximum amount of characters shown when Peeking a register
	* @type {Integer}
	*/
	static MaxPeekCharacters := 100

	/**
	* Put in registers that you don't want to see when using PeekNonEmpty().
	* You can still peek them using Peek()
	* @type {String}
	*/
	static ExplicitPeekOnly := "suf"

	/**
	* Manage your clipboards by writing it to different files.
	* @param {Char} key
	*/
	__New(key) {

		this.IsUpper := IsUpper(key) ? true : false
		try this.key := Registers.ValidateKey(key).ToLower()
		catch UnsetItemError {
			Registers.CancelAction()
			Exit()
		}
	}

	/**
	* @param {Char} key
	* @throws {ValueError} If the key passed isn't in Registers.ValidRegisters
	* @throws {UnsetItemError} If you pass an empty string as the key
	*/
	static ValidateKey(key, sValidKeys?) {
		if !key {
			throw UnsetItemError("
			(
				You didn't pass any key
			)", -1)
		}

		if InStr(Registers.RussianCharacters, key)
			key := Layouts.RusToEng[key]

		sValidKeys := sValidKeys ?? Registers.ValidRegisters

		if !InStr(sValidKeys, key, true) {
			throw ValueError("
			(
				The key you passed isn't supported by Registers.
				Add it to the Registers.ValidRegisters string if you want to use it.
				Some keys aren't going to work even if you do.
			)", -1, key)
		}

		return key
	}

	/**
	* @param {String} path To the register
	* @private
	* @returns {String} Text in the register. Empty string if the register doesn't exist.
	*/
	__TryGetRegisterText(path) {
		if FileExist(path)
			text := ReadFile(path)
		else
			text := ""
		return text
	}

	/**
	* @param {String} text
	* @private
	* @returns {String} Up to first 100 characters in a file, where newlines are replaced by `\n`
	*/
	static __FormatRegister(text) {
		registerContentsNoNewlines := text.RegExReplace("\r?\n", "\n")
		return registerContentsNoNewlines[1, Registers.MaxPeekCharacters]
	}

	/**
	* @param {String} fileName Format: "reg_k.txt"
	* @private
	* @returns {String} The character of a register file. "reg_k.txt" => "k"
	*/
	static __FormatRegisterName(fileName) {
		fileName := fileName.Replace("reg_")
		return fileName.Replace(".txt")
	}

	/**
	* What to do if the user passed an empty key
	* @private
	*/
	static CancelAction() {
		Infos("Action cancelled", Registers.InfoTimeout)
	}

	/**
	* @returns {String} The path of the register of entered key
	*/
	static GetPath(key) => Registers.RegistersDirectory "\reg_" key ".txt"

	/**
	* @returns {String} Text inside of the register file
	*/
	Read() {
		path := Registers.GetPath(this.key)
		return this.__TryGetRegisterText(path)
	}

	/**
	* Remove the contents of a register
	*/
	Truncate() {
		path := Registers.GetPath(this.key)
		WriteFile(path)
		Info(this.key " cleared", Registers.InfoTimeout)
	}

	/**
	* Write the contents of your clipboard to a register
	*/
	Write(text?) {
		path := Registers.GetPath(this.key)
		text := text ?? A_Clipboard
		if !text {
			Info(this.key " empty write denied", Registers.InfoTimeout)
			return
		}
		WriteFile(path, text)
		Info(this.key " clipboard written", Registers.InfoTimeout)
	}

	/**
	* Append the contents of your clipboard to a register
	*/
	Append(text?) {
		path := Registers.GetPath(this.key)
		text := text ?? A_Clipboard
		if !text {
			Info(this.key " empty append denied", Registers.InfoTimeout)
			return
		}
		AppendFile(path, "`n" text)
		Info(this.key " clipboard appended", Registers.InfoTimeout)
	}

	/**
	* Write the contents of your clipboard to a register if you passed a lowercase key.
	* *Append* the contents of your clipbaord to a register if you passed an upppercase key.
	*/
	WriteOrAppend(text?) => this.IsUpper ? this.Append(text?) : this.Write(text?)

	/**
	* Paste the contents of a register
	*/
	Paste() {
		content := this.Read()
		ClipSend(content)
		Info(this.key " pasted", Registers.InfoTimeout)
		return this
	}

	/**
	* Run the contents of a register with the Run() function.
	* One line == one command.
	* For example, you can store 5 links in a register and run that register to open those 5 links at once.
	* Lines that start with `;` are considered comments and don't get ran
	*/
	Run(showOutput := true) {
		cmdie := Cmd()
		output := ""
		text := this.Read()
		text := StrReplace(text, "`r")
		commands := StrSplit(text, "`n")
		for index, command in commands {
			if command ~= "^;"
				continue
			if command ~= "^http" {
				Run(command)
				continue
			}
			output .= cmdie.Execute(command).StdOut
		}
		if output && showOutput
			Infos(output)
	}

	/**
	* Get an info for every register that is not empty.
	* Each info will display the name of the register and its contents.
	* In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
	* (configurable by modifying Registers.MaxPeekCharacters)
	*/
	static PeekNonEmpty() {
		loop files Registers.RegistersDirectory "\*.txt" {
			text := ReadFile(A_LoopFileFullPath)
			if !text {
				continue
			}
			registerChar := Registers.__FormatRegisterName(A_LoopFileName)
			if InStr(Registers.ExplicitPeekOnly, registerChar) {
				continue
			}
			shorterRegisterContents := Registers.__FormatRegister(text)
			Infos(registerChar ": " shorterRegisterContents)
		}
	}

	/**
	* Show the contents of a register in an info.
	* In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
	* (configurable by modifying Registers.MaxPeekCharacters)
	*/
	Peek() {
		text := this.Read()
		shorterRegisterContents := Registers.__FormatRegister(text)
		Infos(this.key ": " shorterRegisterContents)
	}

	/**
	* Show the full contents of a register in an info.
	* If you call this function multiple times without destroying the infos, they will overlap.
	*/
	Look() {
		text := this.Read()
		Infos(this.key ": " text)
	}

	/**
	* Move the contents of one register into another register
	* @param {Char} key2 Register to move to
	* @throws {ValueError} If you pass an unsupported key
	*/
	Move(key2) {
		try key2 := Registers.ValidateKey(key2).ToLower()
		catch UnsetItemError {
			Registers.CancelAction()
			return
		}

		path1 := Registers.GetPath(this.key)
		path2 := Registers.GetPath(key2)

		WriteFile(path2, this.__TryGetRegisterText(path1))
		WriteFile(path1)

		Info(this.key " moved to " key2, Registers.InfoTimeout)
	}

	/**
	* Exchange the contents of two registers.
	* The contents of register 1 will move to register 2, and vice versa.
	* This exists entirely so you don't have to use Registers.Move() three times.
	* @param {Char} key2 Register 2
	*/
	SwitchContents(key2) {
		try key2 := Registers.ValidateKey(key2).ToLower()
		catch UnsetItemError {
			Registers.CancelAction()
			return
		}

		path1 := Registers.GetPath(this.key)
		path2 := Registers.GetPath(key2)

		SwitchFiles(path1, path2)

		Info(this.key " && " key2 " switched", Registers.InfoTimeout)
	}
}
