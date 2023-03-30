#Include <Utils\Choose>
#Include <Loaders\Links>

Linker(linkName) {
    if Links.Has(linkName)
        return Links[linkName]
    options := []
    for key, _ in Links {
        if InStr(key, linkName)
            options.Push(key)
    }
    chosen := Choose(options*)
    if chosen
        return Links[chosen]
    return ""
}