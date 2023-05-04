;Made by @thqby (https://github.com/thqby), rewritten slightly into my style
#Include <Extensions\Json>
Print(toPrint) {
	toPrint_string := ""
	switch Type(toPrint) {
		case "Map", "Array", "Object":
		toPrint_string := JSON.stringify(toPrint)
		default:
		try toPrint_string := String(toPrint)
	}
	try FileAppend(toPrint_string "`n", "*", "utf-8")
}