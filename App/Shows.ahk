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

    static ShowsJsonPath := Paths.Ptf["Shows"]

    static ConsumedPath := Paths.Ptf["Consumed"]

    static shows := _GetJson()

    static showsArr {
        get {
            shows := []
            for key, _ in this.shows {
                shows.Push(key)
            }
            return shows
        }
    }

    static ApplyJson() => WriteFile(this.ShowsJsonPath, JSON.stringify(this.shows))

    static Run(progressType?) => Browser.RunLink(this._GetLink(progressType?))

    static DeleteShow(isDropped := false) {
        if !show := Choose(this.showsArr*)
            return
        this.shows.Delete(show)
        this.ApplyJson()
        this._OperateConsumed(show, isDropped)
    }

    static SetLink(show_and_link) {
        if !show_and_link := this._ValidateSetInput(show_and_link, "(.+) (https:\/\/[^ ]+)") {
            return false
        }

        show := show_and_link[1]
        link := show_and_link[2]

        if !this.shows.Has(show) {
            this._CreateBlankShow(show)
        }
        this.shows[show]["link"] := link

        this.ApplyJson()
        Info(show ": link set")
    }

    static SetEpisode(episode) {
        if !episode := this._ValidateSetInput(episode, "\d+")[] {
            Infos("exited")
            return false
        }

        if !show := Choose(this.showsArr*)
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
        if !downloaded := this._ValidateSetInput(downloaded, "\d+")[] {
            return false
        }

        if !show := Choose(this.showsArr*)
            return
        this.shows[show]["downloaded"] := downloaded

        this.ApplyJson()
        Info(show ": " downloaded)
        Git(Paths.Shows).Add(Paths.Ptf["Shows"]).Commit("download episode " downloaded " of show " show).Push().Execute()
        Info("pushed!")
    }


    static _GetJson() => JSON.parse(ReadFile(this.ShowsJsonPath))

    static _GetLink(progressType := "episode") {
        if !show := Choose(this.showsArr*)
            return
        return this.shows[show]["link"] this.shows[show][progressType] + 1
    }

    static _ValidateSetInput(input, regex) {
        input := CompressSpaces(input)

        RegexMatch(input, regex, &match)
        if !match {
            Info("Wrong!")
            return false
        }
        return match
    }

    static _CreateBlankShow(show) => this.shows.Set(show, Map(
        "episode",    0,
        "link",       "",
        "downloaded", 0,
        "timestamp",  DateTime.Date " " DateTime.Time
    ))

    static _OperateConsumed(show, isDropped) => (this._WriteConsumed(show, isDropped), this._PushConsumed(show, isDropped))

    static _WriteConsumed(show, isDropped) {
        date := "`n1. " DateTime.Date " - "
        isDropped_string := isDropped ? "(dropped) " : ""
        AppendFile(this.ConsumedPath, date isDropped_string show.ToTitle())
    }

    static _PushConsumed(show, isDropped) {
        action := isDropped ? "drop" : "finish"
        Info(action " " show)
        Git(Paths.Shows).Add(this.ConsumedPath, this.ShowsJsonPath).Commit(action " " show).Push().Execute()
        Info("pushed!")
    }
}