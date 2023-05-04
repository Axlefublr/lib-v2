#Include <App\VPN>
#Include <App\Spotify>
#Include <App\Steam>
#Include <App\Gimp>
#Include <App\Davinci>
#Include <App\Telegram>
#Include <App\FL>
#Include <Utils\Win>

CloseButActually() {
	windowClassNames := ["VPN", "Spotify", "Steam", "Gimp", "Davinci", "Telegram", "FL"]
	for , windowClassName in windowClassNames {
		if WinActive(%windowClassName%.winTitle) {
			%windowClassName%.Close()
			return
		}
	}
	Win.Close()
}
