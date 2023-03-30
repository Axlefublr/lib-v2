#Include <Tools\Info>

class Chooser {

    __New(mapObj) {
        this.mapObj := mapObj
    }

    Get(keyName) {
        if this.mapObj.Has(keyName)
            return this.mapObj[keyName]
    }

}