#Include <Tools\Info>

Choose(options*) {
	infoObjs := [Infos("")]
	for index, option in options {
		if infoObjs.Length >= Infos.maximumInfos
			break
		infoObjs.Push(Infos(option))
	}
	loop {
		for index, infoObj in infoObjs {
			if WinExist(infoObj.hwnd)
				continue
			text := infoObj.text
			break 2
		}
	}
	for index, infoObj in infoObjs {
		infoObj.Destroy()
	}
	return text
}