#Include <Links\Github>
#Include <Links\DiscordPins>
#Include <Links\General>
#Include <Links\Channel>
#Include <Links\Memes>
#Include <Links\Tools>
#Include <Links\Docs>
#Include <Links\AhkLib>
#Include <Notes\Code>
#Include <Notes\Info>
#Include <Notes\Tech>
#Include <Notes\Terminal>
#Include <Extensions\Map>
#Include <Tools\StateBulb>

class Environment {

    static Notes := this._GenerateNotesMap()
    static Links := this._GenerateLinksMap()

    static _vimMode := false
    static VimMode {
        get => this._vimMode
        set {
            this._vimMode := value
            if value
                StateBulb[1].Create()
            else {
                StateBulb[1].Destroy()
                this.WindowManagerMode := value
            }
        }
    }

    static _windowManagerMode := false
    static WindowManagerMode {
        get => this._windowManagerMode
        set {
            this._windowManagerMode := value
            if value
                StateBulb[5].Create()
            else
                StateBulb[5].Destroy()
        }
    }


    static _GenerateNotesMap() {
        Notes := Map()
        Notes.SafeSetMap(Notes_Terminal)
        Notes.SafeSetMap(Notes_Code)
        Notes.SafeSetMap(Notes_Tech)
        Notes.SafeSetMap(Notes_Info)
        return Notes
    }

    static _GenerateLinksMap() {
        Links := Map()
        Links.SafeSetMap(Links_General)
        Links.SafeSetMap(Links_Channel)
        Links.SafeSetMap(Links_Memes)
        Links.SafeSetMap(Links_Tools)
        Links.SafeSetMap(Links_Docs)
        Links.SafeSetMap(Links_AhkLib)
        Links.SafeSetMap(Links_DiscordPins)
        Links.SafeSetMap(Links_Github)
        return Links
    }

}