#Include <Tools\Counter>
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

	static shows := JSON.parse(ReadFile(this.ShowsJsonPath))

	static showsArr {
		get {
			shows := []
			for key, _ in this.shows {
				shows.Push(key)
			}
			return shows
		}
	}


	static _linkRegex := "https:.+"


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
		if !show_and_link := this._ValidateSetInput(show_and_link, "(.+) (" this._linkRegex ")") {
			return false
		}

		show := show_and_link[1].ToTitle()
		link := show_and_link[2]

		if !this.shows.Has(show) {
			this._CreateBlankShow(show)
		}
		this.shows[show]["link"] := link

		this.ApplyJson()
		Info(show ": link set")
	}

	static UpdateLink(link) {
		if !link := this._ValidateSetInput(link, this._linkRegex) {
			return false
		}

		if !show := Choose(this.showsArr*) {
			return false
		}

		this.shows[show]["link"] := link

		this.ApplyJson()
		Info(show ": link updated")
	}

	static SetEpisode(episode) {
		if !episode := this._ValidateSetInput(episode, "\d+")[] {
			return false
		}

		if !show := Choose(this.showsArr*)
			return
		this.shows[show]["episode"] := episode
		this.shows[show]["timestamp"] := DateTime.Date " " DateTime.Time

		if episode > this.shows[show]["downloaded"] {
			this.shows[show]["downloaded"] := episode
		}

		this._OperateEpisode(show, episode)
	}

	static SetDownloaded(downloaded) {
		if !downloaded := this._ValidateSetInput(downloaded, "\d+")[] {
			return false
		}

		if !show := Choose(this.showsArr*)
			return
		this.shows[show]["downloaded"] := downloaded

		this._OperateDownloaded(show, downloaded)
	}


	static _GetLink(progressType := "episode") {
		if !show := Choose(this.showsArr*)
			return
		nextEp := this.shows[show][progressType] + 1
		Counter.num := nextEp
		return this.shows[show]["link"] nextEp
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

	static _CreateBlankShow(show) => this.shows.Set(show.ToTitle(), Map(
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
		Git(Paths.Shows)
			.Add(this.ConsumedPath, this.ShowsJsonPath)
			.Commit(action " " show)
			.Push()
			.Execute()
		Info("pushed!")
	}

	static _OperateEpisode(show, episode) {
		this.ApplyJson()
		Info(show ": " episode)
		Git(Paths.Shows)
			.Add(this.ShowsJsonPath)
			.Commit("watch ep" episode " -> " show)
			.Push()
			.Execute()
		Info("pushed!")
	}

	static _OperateDownloaded(show, downloaded) {
		this.ApplyJson()
		Info(show ": " downloaded)
		Git(Paths.Shows)
			.Add(this.ShowsJsonPath)
			.Commit("download ep" downloaded " -> " show)
			.Push()
			.Execute()
		Info("pushed!")
	}
}