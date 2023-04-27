#Include <Utils\Hotstringer>
#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Utils\LangDict>
#Include <Utils\CharGenerator>
#Include <Loaders\Links>
#Include <Utils\ClipSend>

#sc34:: {
    static DynamicHotstrings := Map(

        "radnum", () => Random(1000000, 9999999),
        "date",   () => DateTime.Date,
        "week",   () => DateTime.WeekDay,
        "time",   () => DateTime.Time,
        "dt",     () => DateTime.Date " " DateTime.Time,
        "dwt",    () => DateTime.Date " " DateTime.WeekDay " " DateTime.Time,
        "uclanr", () => GetRandomWord("english") " ",
        "ilandh", () => GetRandomWord("russian") " ",
        "chrs",   () => CharGenerator(2).GenerateCharacters(15),

    )
    static StaticHotstrings := Map(

        ;; Words

        "imm", "immediately ", ; it's a hard word okay!

        ;; Nicknames

        "micha",    "Micha-ohne-el",
        "reiwa",    "rbstrachan",
        "anon",     "anonymous1184",
        "geekdude", "G33kDude",
        "me",       "Axlefublr",

        ;; Command line

        "h",    "--help",
        "hl",   "--help | less",
        "l",    "| less",
        "proj", "--project ",

        ;; Copypastas

        "queen",
        "Ok, hear me out: The queen is obviously a female, right? Every pawn can turn into a queen when they are at the other end of the board. That's pretty common knowledge, but here comes the kicker: Considering chess is an ancient game, and also considering in the olden times changing your gender wasn't common at all the pawns have to be female, alright? Pretty sexy, huh? So we established, that all pawns are female. But what about the other non-king pieces? A bishop, a horsey and an inanimate tower (well, it can move actually). All pretty unsexy. Buuuut, the pawns can turn into them! So they have to be female too. People still can't turn into horses or towers (even if they are trying), so I imagine them being sexy chicks in costumes. Like normal (sexy) halloween costumes for women. What does this all mean? The only male piece on the board is the king surrounded by sexy women. The king and his harem. A delicous image, it almost drives me crazy. And here comes the thing, that brings it over the top. The reason I can't play this game anymore as I am always too horny and distracted: Two kings and their harems fighting. Taking pieces aka capturing the other harem's luscious women and enslaving them to be part of one's own harem until one king has to give up, therefore doubling the size of your harem. Thirty (!) hot and willing women all ready for mating. Ready to do everything the king commands, just like on the battlefield, but this battlefield is in the bed. Oh boy, writing this made me too horny again. I gotta go and play a round of my private, personal version of this unbelievably arousing game. The people of the olden times really knew what's up.",

        "gnulinux", "
        (
            I'd just like to interject for a moment. What you're refering to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX.
            Many computer users run a modified version of the GNU system every day, without realizing it. Through a peculiar turn of events, the version of GNU which is widely used today is often called Linux, and many of its users are not aware that it is basically the GNU system, developed by the GNU Project.
            There really is a Linux, and these people are using it, but it is just a part of the system they use. Linux is the kernel: the program in the system that allocates the machine's resources to the other programs that you run. The kernel is an essential part of an operating system, but useless by itself; it can only function in the context of a complete operating system. Linux is normally used in combination with the GNU operating system: the whole system is basically GNU with Linux added, or GNU/Linux. All the so-called Linux distributions are really distributions of GNU/Linux!
        )",

        "math", "
        (
            STOP. DOING. MATH. Numbers were not supposed to be given names! YEARS of counting yet NO REAL WORLD USE for going higher than your FINGERS. Wanted to go higher anyway for a laugh? We had a tool for that, it was called GUESSING. "Yes please give me ZERO of something. Please give me INFINITY of it." Statements dreamed of by the utterly deranged! LOOK at what mathematicians have been DEMANDING YOUR RESPECT for with all the calculators and abacus we built for them. This is REAL math done by REAL mathematicians: "Hello, I would like *** apples please." They have played us for absolute FOOLS.
        )",

    )
    Hotstringer.DynamicHotstrings := DynamicHotstrings
    Hotstringer.StaticHotstrings := StaticHotstrings
    Hotstringer.EndKeys .= "{Enter}{Tab} "
    Hotstringer.Initiate()
}
