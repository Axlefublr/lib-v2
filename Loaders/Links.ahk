#Include <Links\General>
#Include <Links\Channel>
#Include <Links\Memes>
#Include <Links\Tools>
#Include <Links\Docs>
#Include <Links\AhkLib>
#Include <Extensions\Map>

if !IsSet(Links) {
    Links := Map()
    Links.SafeSetMap(Links_General)
    Links.SafeSetMap(Links_Channel)
    Links.SafeSetMap(Links_Memes)
    Links.SafeSetMap(Links_Tools)
    Links.SafeSetMap(Links_Docs)
    Links.SafeSetMap(Links_AhkLib)
}