#Include <Extensions\Gui>
#Include <Tools\CleanInputBox>
#Include <Tools\Info>
#Include <Extensions\String>

Class FileSystemSearch extends Gui {

	/**
	 * Find all the matches of your search request within the currently
	 * opened folder in the explorer.
	 * The searcher recurses into all the subfolders.
	 * Will search for both files and folders.
	 * After the search is completed, will show all the matches in a list.
	 * Call StartSearch() after creating the class instance if you can pass
	 * the input yourself.
	 * Call GetInput() after creating the class instance if you want to have
	 * an input box to type in your search into.
	 */
	__New(searchWhere?, caseSense := "Off") {
		super.__New("+Resize", "These files match your search:")

		this.MakeFontNicer(14)
		this.DarkMode()

		this.List := this.AddText(, "
		(
			Right click on a result to copy its full path.
			Double click to open it in explorer.
		)")

		this.WidthOffset  := 35
		this.HeightOffset := 80

		this.List := this.AddListView(
			"Count50 Background" this.BackColor,
			/**
			 * Count50 — we're not losing much by allocating more memory
			 * than needed,
			 * and on the other hand we improve the performance by a lot
			 * by doing so
			 */
			["File", "Folder", "Directory"]
		)

		this.caseSense := caseSense

		if !IsSet(searchWhere) {
			this.ValidatePath()
		} else {
			this.path := searchWhere
		}

		this.SetOnEvents()
	}

	/**
	 * Get an input box to type in your search request into.
	 * Get a list of all the matches that you can open in explorer.
	 */
	GetInput() {
		if !input := CleanInputBox().WaitForInput() {
			return false
		}
		this.StartSearch(input)
	}

	ValidatePath() {
		SetTitleMatchMode("RegEx")
		try this.path := WinGetTitle("^[A-Z]: ahk_exe explorer\.exe")
		catch Any {
			Info("Open an explorer window first!")
			Exit()
		}
	}

	/**
	 * Get a list of all the matches of *input*.
	 * You can either open them in explorer or copy their path.
	 * @param input *String*
	 */
	StartSearch(input) {
		/**
		 * Improves performance rather than keeping on adding rows
		 * and redrawing for each one of them
		 */
		this.List.Opt("-Redraw")

		;To remove the worry of "did I really start the search?"
		gInfo := Infos("The search is in progress")

		if this.path ~= "^[A-Z]:\\$" {
			this.path := this.path[1, -2]
		}

		loop files this.path "\*.*", "FDR" {
			if !A_LoopFileName.Find(input, this.caseSense) {
				continue
			}
			if A_LoopFileAttrib.Find("D")
				this.List.Add(, , A_LoopFileName, A_LoopFileDir)
			else if A_LoopFileExt
				this.List.Add(, A_LoopFileName, , A_LoopFileDir)
		}

		try WinClose(gInfo.Hwnd)

		this.List.Opt("+Redraw")
		this.List.ModifyCol() ;It makes the columns fit the data — @rbstrachan

		this.Show("AutoSize")
	}

	DestroyResultListGui() {
		this.Minimize()
		this.Destroy()
	}

	SetOnEvents() {
		this.List.OnEvent("DoubleClick",
			(guiCtrlObj, selectedRow) => this.ShowResultInFolder(selectedRow)
		)
		this.List.OnEvent("ContextMenu",
			(guiCtrlObj, rowNumber, *) => this.CopyPathToClip(rowNumber)
		)
		this.OnEvent("Size",
			(guiObj, minMax, width, height) => this.FixResizing(width, height)
		)
		this.OnEvent("Escape", (guiObj) => this.DestroyResultListGui())
	}

	FixResizing(width, height) {
		this.List.Move(,, width - this.WidthOffset, height - this.HeightOffset)
		/**
		 * When you resize the main gui, the listview also gets resize to have the same
		 * borders as usual.
		 * So, on resize, the onevent passes *what* you resized and the width and height
		 * that's now the current one.
		 * Then you can use that width and height to also resize the listview in relation
		 * to the gui
		 */
	}

	ShowResultInFolder(selectedRow) {
		try Run("explorer.exe /select," this.GetPathFromList(selectedRow))
		/**
		 * By passing select, we achieve the cool highlighting thing when the file / folder
		 * gets opened. (You can pass command line parameters into the run function)
		 */
	}

	CopyPathToClip(rowNumber) {
		A_Clipboard := this.GetPathFromList(rowNumber)
		Info("Path copied to clipboard!")
	}

	GetPathFromList(rowNumber) {
		/**
		 * The OnEvent passes which row we interacted with automatically
		 * So we read the text that's on the row
		 * And concoct it to become the full path
		 * This is much better performance-wise than adding all the full paths to an array
		 * while adding the listviews (in the loop) and accessing it here.
		 * Arguably more readable too
		 */

		file := this.List.GetText(rowNumber, 1)
		dir  := this.List.GetText(rowNumber, 2)
		path := this.List.GetText(rowNumber, 3)

		return path "\" file dir ;No explanation required, it's just logic — @rbstrachan
	}
}
