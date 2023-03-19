#Include <Extensions\Gui>

class Point {

    __New() {

    }


    Size {
        get => this.unit * this.multiplier
        set => this.multiplier := value
    }


    unit := A_ScreenDPI / 96
    multiplier := 50


    Create() {

    }

    Destroy() {

    }


    _Show() {

    }

}