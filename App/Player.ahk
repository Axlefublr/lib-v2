#Include <Utils\Win>
#Include <App\Spotify>
#Include <App\Browser>
#Include <App\Youtube>

Class Player {
    static exeTitle := "ahk_exe KMPlayer64.exe"
    static winTitle := this.exeTitle

    static winObj := Win({winTitles: [
        Spotify.exeTitle,
        this.winTitle,
        "WatchMoviesHD " Browser.exeTitle,
        "Gogoanime " Browser.exeTitle,
        Youtube.winTitle
    ]})
}