#Include <Utils\Win>

Class Autohotkey {

	static path := A_ProgramFiles "\AutoHotkey"
	; static currVersion := this.path "\v" A_AhkVersion
	static currVersion := this.path "\v2"
	static v1Version := this.path "\v1.1.34.04"
	static processExe := A_AhkPath
	static exeTitle := "ahk_exe " this.processExe

	Class Docs extends Autohotkey {

		static exeTitle := "ahk_exe hh.exe"

		Class v2 extends Autohotkey.Docs {

			static winTitle := "AutoHotkey v2 Help " super.exeTitle
			static path := super.currVersion "\AutoHotkey.chm"

			static winObj := Win({
				winTitle: this.winTitle,
				exePath: this.path
			})
		}
		Class v1 extends Autohotkey.Docs {

			static winTitle := "AutoHotkey Help " super.exeTitle
			static path := super.v1Version "\AutoHotkey.chm"

			static winObj := Win({
				winTitle: this.winTitle,
				exePath: this.path
			})
		}

		static SetupGroup() {

			static ranAlready := false

			if ranAlready {
				return
			}

			GroupAdd("AhkDocs", this.v2.winTitle)
			GroupAdd("AhkDocs", this.v1.winTitle)

			ranAlready := true
		}

	}
}

Autohotkey.Docs.SetupGroup()