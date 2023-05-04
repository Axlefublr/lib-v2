#Include <Extensions\Gui>

ToggleInfo(text) {
	g_ToggleInfo := Gui("AlwaysOnTop -Caption +ToolWindow").DarkMode().MakeFontNicer()
	g_ToggleInfo.Add("Text",, text)
	g_ToggleInfo.Show("W225 NA x1595 y640")
	SetTimer(() => g_ToggleInfo.Destroy(), -1000)
	return g_ToggleInfo
}
