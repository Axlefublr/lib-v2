; #Include <Utils\KeyChorder> ; Suggested, but not required. Most methods require you to pass the key of a register, you can use KeyChorder to do so.
#Include <Paths> ; For you, this isn't required. For me, it is.
#Include <Abstractions\Text>
#Include <Tools\Info>
#Include <Extensions\String>

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
     * The maximum amount of characters shown when Peeking a register
     * @type {Integer}
     */
    static MaxPeekCharacters := 100

    /**
     * @param key ***String*** — The key of the register to get the path of
     * @returns {String} The path of the register of entered key
     */
    static GetPath(key) => this.RegistersDirectory "\reg_" key ".txt"

    /**
     * @param key ***Char*** — Register key
     * @returns {String} Text inside of the register file
     * @throws {ValueError} If you pass an unsupported key
     */
    static Read(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            return ""
        }
        path := this.GetPath(key)
        return this.__TryGetRegisterText(path)
    }

    /**
     * @param key ***Char***
     * @private
     * @throws {ValueError} If the key passed isn't in Registers.ValidRegisters
     */
    static __ValidateKey(key) {
        if !key {
            throw UnsetItemError("
            (
                You didn't pass any key
            )", -1)
        }
        else if !InStr(this.ValidRegisters, key, true) {
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
     * @param path ***String*** — To the register
     * @private
     * @returns {String} Text in the register. Empty string if the register doesn't exist.
     */
    static __TryGetRegisterText(path) {
        if FileExist(path)
            text := ReadFile(path)
        else
            text := ""
        return text
    }

    /**
     * @param text ***String***
     * @private
     * @returns {String} Up to first 100 characters in a file, where newlines are replaced by `\n`
     */
    static __FormatRegister(text) {
        registerContentsNoNewlines := text.RegExReplace("\r?\n", "\n")
        return registerContentsNoNewlines[1, this.MaxPeekCharacters]
    }

    /**
     * @param fileName ***String*** — Format: "reg_k.txt"
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
    static __CancelAction() {
        Infos("Action cancelled", this.InfoTimeout)
    }

    /**
     * Remove the contents of a register
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Truncate(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            this.__CancelAction()
            return
        }
        path := this.GetPath(key)
        WriteFile(path)
        Info(key " cleared", this.InfoTimeout)
    }

    /**
     * Write the contents of your clipboard to a register
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Write(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            this.__CancelAction()
            return
        }
        path := this.GetPath(key)
        WriteFile(path, A_Clipboard)
        Info(key " clipboard written", this.InfoTimeout)
    }

    /**
     * Append the contents of your clipboard to a register
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Append(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            this.__CancelAction()
            return
        }
        path := this.GetPath(key)
        AppendFile(path, "`n" A_Clipboard)
        Info(key " clipboard appended", this.InfoTimeout)
    }

    /**
     * Write the contents of your clipboard to a register if you passed a lowercase key.
     * *Append* the contents of your clipbaord to a register if you passed an upppercase key.
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static WriteOrAppend(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            this.__CancelAction()
            return
        }
        path := this.GetPath(key)
        if IsUpper(key) {
            AppendFile(path, "`n" A_Clipboard)
            Info(key " clipboard appended", this.InfoTimeout)
        }
        else {
            WriteFile(path, A_Clipboard)
            Info(key " clipboard written", this.InfoTimeout)
        }
    }

    /**
     * Paste the contents of a register
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Paste(key) {
        content := this.Read(key)
        ClipSend(content)
        Info(key " pasted", this.InfoTimeout)
    }

    /**
     * Run the contents of a register with the Run() function.
     * One line == one command.
     * For example, you can store 5 links in a register and run that register to open those 5 links at once.
     * Lines that start with `;` are considered comments and don't get ran
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Run(key) {
        text := this.Read(key)
        commands := StrSplit(text, "`n")
        for index, command in commands {
            if command ~= "^;"
                continue
            Run(command)
        }
        Info(key " commands executed", this.InfoTimeout)
    }

    /**
     * Get an info for every register that is not empty.
     * Each info will display the name of the register and its contents.
     * In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
     * (configurable by modifying Registers.MaxPeekCharacters)
     */
    static PeekNonEmpty() {
        loop files this.RegistersDirectory "\*.txt" {
            text := ReadFile(A_LoopFileFullPath)
            if !text {
                continue
            }
            shorterRegisterContents := this.__FormatRegister(text)
            Infos(this.__FormatRegisterName(A_LoopFileName) ": " shorterRegisterContents)
        }
    }

    /**
     * Show the contents of a register in an info.
     * In the contents shown, newlines will be replaced by "\n" and only up to 100 characters are shown for each one.
     * (configurable by modifying Registers.MaxPeekCharacters)
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Peek(key) {
        try this.__ValidateKey(key)
        catch UnsetItemError {
            this.__CancelAction()
            return
        }
        text := this.Read(key)
        shorterRegisterContents := this.__FormatRegister(text)
        Infos(key ": " shorterRegisterContents)
    }

    /**
     * Show the full contents of a register in an info.
     * If you call this function multiple times without destroying the infos, they will overlap.
     * @param key ***Char*** — Register key
     * @throws {ValueError} If you pass an unsupported key
     */
    static Look(key) {
        text := this.Read(key)
        Infos(text)
    }

    /**
     * Move the contents of one register into another register
     * @param key1 ***Char*** — Register to move from
     * @param key2 ***Char*** — Register to move to
     * @throws {ValueError} If you pass an unsupported key
     */
    static Move(key1, key2) {
        try {
            this.__ValidateKey(key1)
            this.__ValidateKey(key2)
        }
        catch UnsetItemError {
            this.__CancelAction()
            return
        }

        path1 := this.GetPath(key1)
        path2 := this.GetPath(key2)

        WriteFile(path2, this.__TryGetRegisterText(path1))
        WriteFile(path1)

        Info(key1 " moved to " key2, this.InfoTimeout)
    }

    /**
     * Currently doesn't work: has a chance to remove the contents of one register without moving it to another.
     * Exchange the contents of two registers.
     * The contents of register 1 will move to register 2, and vice versa.
     * This exists entirely so you don't have to use Registers.Move() three times.
     * @param key1 ***Char*** — Register 1
     * @param key2 ***Char*** — Register 2
     * @throws {ValueError} If you pass an unsupported key
     */
    static SwitchContents(key1, key2) {
        try {
            this.__ValidateKey(key1)
            this.__ValidateKey(key2)
        }
        catch UnsetItemError {
            this.__CancelAction()
            return
        }

        path1 := this.GetPath(key1)
        path2 := this.GetPath(key2)

        SwitchFiles(path1, path2)

        Info(key1 " && " key2 " switched", this.InfoTimeout)
    }
}
