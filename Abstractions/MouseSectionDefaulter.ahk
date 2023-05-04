#Include <Abstractions\Base>
#Include <App\VsCode>

class MouseSectionDefaulter {

	static Browser(sections) {
		Switch {
			Case sections.right: NextTab()
			Case sections.left:  PrevTab()
			Case sections.down:  CloseTab()
			Case sections.up:    RestoreTab()
		}
	}

	static VsCode(sections) {
		Switch {
			Case sections.right: NextTab()
			Case sections.left:  PrevTab()
			Case sections.down:  VsCode.CloseTab()
			Case sections.up:    RestoreTab()
		}
	}

}
