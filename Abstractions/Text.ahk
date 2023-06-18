CompressSpaces(text) => RegexReplace(text, " {2,}", " ")

/**
* Syntax sugar. Write text to a file
* @param whichFile *String* The path to the file
* @param text *String* The text to write
*/
WriteFile(whichFile, text := "") {
	fileObj := FileOpen(whichFile, "w", "UTF-8-RAW")
	fileObj.Write(text)
}

/**
* Syntax sugar. Append text to a file, or write it if the file
* doesn't exist yet
* @param whichFile *String* The path to the file
* @param text *String* The text to write
*/
AppendFile(whichFile, text) => FileAppend(text, whichFile, "UTF-8-RAW")

/**
* Syntax sugar. Reads a file and returns the text in it
* @param whichFile *String* The path to the file to read
* @returns {String}
*/
ReadFile(whichFile) => FileRead(whichFile, "UTF-8-RAW")

/**
* Switch the contents of two files.
* The contents of file a will now be in file b, and the contents of file b will now be in file a.
* "Why not just use ReadFile and then WriteFile?" — Closing the file objects happens slower than ahk thinks.
* Because of this, there's a chance to have a failed write to one of the files, losing the data you were trying to write to it.
* Meaning, you end up with one file's contents just lost, effectively moving one file onto another.
* And there's no worse thing than code that works only *sometimes*.
* @param path1 ***String***
* @param path2 ***String***
*/
SwitchFiles(path1, path2) {

	file1Read := FileOpen(path1, "r", "UTF-8-RAW")
	file1Read.Seek(0, 0)

	file2Read := FileOpen(path2, "r", "UTF-8-RAW")
	file2Read.Seek(0, 0)

	text1 := file1Read.Read()
	text2 := file2Read.Read()

	file1Write := FileOpen(path1, "w", "UTF-8-RAW")

	file2Write := FileOpen(path2, "w", "UTF-8-RAW")

	file1Write.Write(text2)
	file2Write.Write(text1)

	file1Read.Close()
	file2Read.Close()

	file1Write.Close()
	file2Write.Close()
}