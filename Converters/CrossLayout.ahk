; No dependencies

class CrossLayout {

    static RusToEng := Map(
        "й", "q",
        "ц", "w",
        "у", "e",
        "к", "r",
        "е", "t",
        "н", "y",
        "г", "u",
        "ш", "i",
        "щ", "o",
        "з", "p",
        "х", "[",
        "ъ", "]",
        "ф", "a",
        "ы", "s",
        "в", "d",
        "а", "f",
        "п", "g",
        "р", "h",
        "о", "j",
        "л", "k",
        "д", "l",
        "ж", ";",
        "э", "'",
        "я", "z",
        "ч", "x",
        "с", "c",
        "м", "v",
        "и", "b",
        "т", "n",
        "ь", "m",
        "б", ",",
        "ю", ".",
        ".", "/",
    )

    static __Item[character] {
        get => this.RusToEng[character]
    }
}