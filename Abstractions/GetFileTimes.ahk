; No dependencies

GetFileTimes(filePath) {
	oFile := FileOpen(filePath, 0x700)
	DllCall("GetFileTime",
		"Ptr",    oFile.Handle,
		"int64*", &creationTime     := 0,
		"int64*", &accessedTime     := 0,
		"int64*", &modificationTime := 0
	)
	return {
		CreationTime:     creationTime,
		AccessedTime:     accessedTime,
		ModificationTime: modificationTime
	}
}
