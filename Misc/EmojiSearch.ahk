#Include <Tools\InternetSearch>
#Include <Paths>

EmojiSearch(emojiName) {
	if !emojiName := Trim(emojiName)
		return
	emojiName := StrReplace(emojiName, " ", "-")
	loop files Paths.Emoji "\*.*", "FR" {
		if A_LoopFileName ~= emojiName
			Info(A_LoopFileFullPath)
	}
	InternetSearch("Emoji").FeedQuery(emojiName)
}