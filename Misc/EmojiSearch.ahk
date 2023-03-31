#Include <Tools\InternetSearch>
#Include <Paths>

EmojiSearch(emojiName) {
    foundEmojis := []
    loop files Paths.Emoji "\*.*" {
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