#Include <Notes\Terminal>
#Include <Extensions\Map>

if !IsSet(Notes) {
    Notes := Map()
    Notes.SafeSetMap(Notes_Terminal)
}