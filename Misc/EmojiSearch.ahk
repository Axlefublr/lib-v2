#Include <Tools\InternetSearch>
#Include <Paths>

EmojiSearch(emojiName) {
	if !emojiName := Trim(emojiName)
		return
	foundEmojis := []
	emojiName := StrReplace(emojiName, " ", "-")
	loop files Paths.Emoji "\*.*", "FR" {
		if A_LoopFileName ~= emojiName
			foundEmojis.Push(A_LoopFileFullPath)
	}
	if !foundEmojis.Length {
		InternetSearch("Emoji").FeedQuery(emojiName)
		return
	}
	for index, emojiFile in foundEmojis {
		Run("explorer.exe /select, " emojiFile)
	}
}