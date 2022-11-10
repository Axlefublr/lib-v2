CompressSpaces(text) => RegexReplace(text, " {2,}", " ")

/**
 * Syntax sugar. Write text to a file
 * @param whichFile *String* The path to the file
 * @param text *String* The text to write
 */
WriteFile(whichFile, text := "") {
   fileObj := FileOpen(whichFile, "w", "UTF-8-RAW")
   fileObj.Write(text)
   fileObj.Close()
}

/**
 * Syntax sugar. Append text to a file, or write it if the file 
 * doesn't exist yet
 * @param whichFile *String* The path to the file
 * @param text *String* The text to write
 */
AppendFile(whichFile, text) {
   if FileExist(whichFile)
      fileObj := FileOpen(whichFile, "a")
   else
      fileObj := FileOpen(whichFile, "w")
   fileObj.Seek(0, 2)
   fileObj.Write(text)
   fileObj.Close()
}

/**
 * Syntax sugar. Reads a file and returns the text in it
 * @param whichFile *String* The path to the file to read
 * @returns {String}
 */
ReadFile(whichFile) {
   fileObj := FileOpen(whichFile, "r")
   fileObj.Seek(0, 0)
   text := fileObj.Read()
   fileObj.Close()
   return text
}
