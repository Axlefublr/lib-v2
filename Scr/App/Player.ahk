#Include <App\Player>
#Include <Win>

#HotIf Player.winObj.AreActive()
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"
#HotIf