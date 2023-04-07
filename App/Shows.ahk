#Include <Utils\Choose>
#Include <App\Git>
#Include <Extensions\Json>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Tools\Info>
#Include <Utils\Win>
#Include <App\Browser>
#Include <Extensions\String>
#Include <Converters\DateTime>

class Shows {

    static showsJson := Paths.Ptf["Shows"]

    static shows := GetJson()

    static GetJson() => JSON.parse(ReadFile(this.showsJson))
    static ApplyJson() => WriteFile(this.showsJson, JSON.stringify(this.shows))

    static CreateBlankShow(show) => this.shows.Set(show, Map(
        "episode",    0,
        "link",       "",
        "downloaded", 0,
        "timestamp",  DateTime.Date " " DateTime.Time
    ))

    static ValidateShow(show) {
        try this.shows[show]
        catch Any {
            return false ;There for sure won't be a link nor an episode if the object doesn't exist yet, because if I either set the link or the episode, the show object will exist along with the properties, even if one of them doesn't have a non-zero value
        }
        return true
    }

    static GetShows() {
        shows := []
        for key, _ in this.shows {
            shows.Push(key)
        }
        return shows
    }

    static Run(show, progressType?) {
        try Run(this._GetLink(show, progressType?))
        catch Any {
            Info("Fucked up link :(")
            return
        }
        Browser.winObj.Activate()
    }

    static DeleteShow(show?, isDropped := false) {
        if !IsSet(show) {
            if !show := Choose(this.GetShows()*)
                return
        }
        try {
            this.shows.Delete(show)
            this.ApplyJson()
        }
        this._WriteConsumed(show, isDropped)
        this._PushConsumed(show, isDropped)
    }

    static ValidateSetInput(input, regex) {
        input := CompressSpaces(input)

        RegexMatch(input, regex, &match)
        if !match {
            Info("Wrong!")
            return false
        }
        return match
    }

    static SetLink(show_and_link) {
        if !show_and_link := this.ValidateSetInput(show_and_link, "(.+) (https:\/\/[^ ]+)") {
            return false
        }

        show := show_and_link[1]
        link := show_and_link[2]

        if !this.ValidateShow(show) {
            this.CreateBlankShow(show)
        }
        this.shows[show]["link"] := link

        this.ApplyJson()
        Info(show ": link set")
    }

    static SetEpisode(episode) {
        if !episode := this.ValidateSetInput(episode, "\d+")[] {
            Infos("exited")
            return false
        }

        if !show := Choose(this.GetShows()*)
            return
        this.shows[show]["episode"] := episode
        this.shows[show]["timestamp"] := DateTime.Date " " DateTime.Time

        if episode > this.shows[show]["downloaded"] {
            this.shows[show]["downloaded"] := episode
        }

        this.ApplyJson()
        Info(show ": " episode)
        Git(Paths.Shows).Add(Paths.Ptf["Shows"]).Commit("watch episode " episode " of show " show).Push().Execute()
        Info("pushed!")
    }

    static SetDownloaded(downloaded) {
        if !downloaded := this.ValidateSetInput(downloaded, "\d+")[] {
            return false
        }

        if !show := Choose(this.GetShows()*)
            return
        this.shows[show]["downloaded"] := downloaded

        this.ApplyJson()
        Info(show ": " downloaded)
        Git(Paths.Shows).Add(Paths.Ptf["Shows"]).Commit("download episode " downloaded " of show " show).Push().Execute()
        Info("pushed!")
    }


    static _GetLink(progressType := "episode") {
        if !show := Choose(this.GetShows()*)
            return
        return this.shows[show]["link"] this.shows[show][progressType] + 1
    }

    static _WriteConsumed(show, isDropped := false) {
        date := "`n1. " DateTime.Date " - "
        isDropped_string := isDropped ? "(dropped)" : ""
        AppendFile(Paths.Ptf["Consumed"], date isDropped_string show.ToTitle())
    }

    static _PushConsumed(show, isDropped := false) {
        action := isDropped ? "drop" : "finish"
        Info(action " " show)
        Git(Paths.Shows).Add(Paths.Ptf["Consumed"], Paths.Ptf["Shows"]).Commit(action " " show).Push().Execute()
        Info("pushed!")
    }
}