#Include <Links\General>
#Include <Links\Channel>
#Include <Links\Memes>
#Include <Links\Cool>
#Include <Links\Tools>
#Include <Links\Software>
#Include <Links\Docs>
#Include <Links\Learning>
#Include <Links\Github>
#Include <Links\AhkLib>
#Include <Extensions\Map>

if !IsSet(Links) {
    Links := Map()
    Links.SafeSetMap(Links_General)
    Links.SafeSetMap(Links_Channel)
    Links.SafeSetMap(Links_Memes)
    Links.SafeSetMap(Links_Cool)
    Links.SafeSetMap(Links_Tools)
    Links.SafeSetMap(Links_Software)
    Links.SafeSetMap(Links_Docs)
    Links.SafeSetMap(Links_Learning)
    Links.SafeSetMap(Links_Github)
    Links.SafeSetMap(Links_AhkLib)
}