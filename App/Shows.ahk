#Include <Json>
#Include <Text>
#Include <Paths>
#Include <Get>
#Include <Tools\Info>
#Include <Win>
#Include <App\Browser>
#Include <String>

Class Shows {
   __New() {
      this.shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   }
   
   ApplyJson() => WriteFile(Paths.Ptf["Shows"], JSON.stringify(this.shows))

   CreateBlankShow(show) => this.shows.Set(show, Map("episode", 0, "link", "", "downloaded", 0, "timestamp", GetDateAndTime()))
   
   ValidateShow(show) {
      try this.shows[show]
      catch Any {
         return false ;There for sure won't be a link nor an episode if the object doesn't exist yet, because if I either set the link or the episode, the show object will exist along with the properties, even if one of them doesn't have a non-zero value
      }
      return true
   }
   
   ValidateShowLink(show) {
      if !this.ValidateShow(show) {
         return false
      }
      if !this.shows[show]["link"] {
         Info("No link!🔗")
         return false ;If the object exists, so does the link property, which will be blank if I only set the episode (somehow). The episode always starts out being 0 though, no need to check for it
      }
      return true
   }
   
   GetLink(show, progressType := "episode") {
      if !this.ValidateShowLink(show) {
         return ""
      }
      return this.shows[show]["link"] this.shows[show][progressType] + 1
   }
   
   GetList() {
      for key, value in this.shows {
         Infos(key)
      }
   }

   Run(show, progressType?) {
      try Run(this.GetLink(show, progressType?))
      catch Any {
         Info("Fucked up link :(")
         return
      }
      Win({winTitle: Browser.winTitle}).Activate()
   }
      
   DeleteShow(show, isDropped := false) {
      try {
         this.shows.Delete(show)
         this.ApplyJson()
      }
      this.UpdateConsumed(show, isDropped)
   }
   
   UpdateConsumed(show, isDropped) => (
      date := "`n1. " GetDate() " - ",
      isDropped_string := isDropped ? " - dropped" : "",
      AppendFile(Paths.Ptf["Consumed"], date show.ToTitle() isDropped_string)
   )

   ValidateSetInput(input, regex) {
      input := CompressSpaces(input)
      
      RegexMatch(input, regex, &match)
      if !match {
         Info("Wrong!")
         return false
      }
      return match
   }

   SetLink(show_and_link) {
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

   SetEpisode(show_and_episode) {
      if !show_and_episode := this.ValidateSetInput(show_and_episode, "(.+) (\d+)") {
         return false
      }
      
      show    := show_and_episode[1]
      episode := show_and_episode[2]

      if !this.ValidateShow(show) {
         this.CreateBlankShow(show)
      }
      this.shows[show]["episode"] := episode
      this.shows[show]["timestamp"] := GetDateAndTime()

      if episode > this.shows[show]["downloaded"] {
         this.shows[show]["downloaded"] := episode
      }

      this.ApplyJson()
      Info(show ": " episode)
   }
   
   SetDownloaded(show_and_downloaded) {
      if !match := this.ValidateSetInput(show_and_downloaded, "(.+) (\d+)") {
         return false
      }

      show       := match[1]
      downloaded := match[2]

      if !this.ValidateShow(show) {
         this.CreateBlankShow(show)
      }
      this.shows[show]["downloaded"] := downloaded

      this.ApplyJson()
      Info(show ": " downloaded)
   }
}