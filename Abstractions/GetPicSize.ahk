; No dependencies

GetPicSize(picturePath) {
	hModule := DllCall("LoadLibrary", "Str", "gdiplus")
	si := Buffer(A_PtrSize = 8 ? 24 : 16, 0)
	NumPut "Int", 1, si
	DllCall "gdiplus\GdiplusStartup", "Ptr*", &pToken := 0, "Ptr", si, "Ptr", 0
	DllCall "gdiplus\GdipCreateBitmapFromFile", "Str", picturePath, "Ptr*", &pBitmap := 0
	DllCall "gdiplus\GdipGetImageDimension", "Ptr", pBitmap, "Float*", &w := 0, "Float*", &h := 0
	DllCall "gdiplus\GdiplusShutdown", "Ptr", pToken
	DllCall "FreeLibrary", "Ptr", hModule
	return { Width: Round(w), Height: Round(h) }
}