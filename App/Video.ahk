#Include <Paths>
#Include <Cmd>
#Include <Sort>
#Include <Win>

Class Video {

   static EditScreenshot() {
      selectedFile := FileSelect("S", Paths.Materials, "Select a file to edit in gimp")
      if !selectedFile
         return

      RunWith(Paths.Apps["Gimp"], selectedFile)
   }

   static DuplicateScreenshot() {
      file_path := FileSelect("s", Paths.Materials, "Choose a screenshot to duplicate")

      SplitPath(file_path, &file_fullname)
      file_name := RegexReplace(file_fullname, "\d+")

      screenshot_numbers := []
      Loop Files Paths.Materials "\*.png" {
         RegexMatch(A_LoopFileName, "\d+", &currentFile_number)
         screenshot_numbers.Push(currentFile_number[0])
      }
      screenshot_numbers := InsertionSort(screenshot_numbers)

      nextNumber := screenshot_numbers[-1] + 1

      newFile_path := Paths.Materials "\" nextNumber file_name

      FileCopy(file_path, newFile_path, 1)
      win_RunAct_Folders(Paths.Materials)
   }
}