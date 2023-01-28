; No dependencies

/**
 * By default, you can set the same key to a map multiple times.
 * Naturally, you'll be able to reference only one of them, which is likely not the behavior you want.
 * This function will throw an error if you try to set a key that already exists in the map.
 * @param mapObj ***Map*** to set the key-value pair into
 * @param key ***String***
 * @param value ***Any***
 */
SafeSet(mapObj, key, value) {
    if !mapObj.Has(key) {
        mapObj.Set(key, value)
        return
    }
    throw IndexError("Map already has key", -1, key)
}
Map.Prototype.DefineProp("SafeSet", {Call: SafeSet})

/**
 * A version of SafeSet that you can just pass another map object into to set everything in it.
 * Will still throw an error for every key that already exists in the map.
 * @param mapObj ***Map*** the initial map
 * @param mapToSet ***Map*** the map to set into the initial map
 */
SafeSetMap(mapObj, mapToSet) {
    for key, value in mapToSet {
        SafeSet(mapObj, key, value)
    }
}
Map.Prototype.DefineProp("SafeSetMap", {Call: SafeSetMap})