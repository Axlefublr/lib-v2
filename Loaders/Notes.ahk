#Include <Notes\Tech>
#Include <Notes\Code>
#Include <Notes\Terminal>
#Include <Extensions\Map>

if !IsSet(Notes) {
    Notes := Map()
    Notes.SafeSetMap(Notes_Terminal)
    Notes.SafeSetMap(Notes_Code)
    Notes.SafeSetMap(Notes_Tech)
}