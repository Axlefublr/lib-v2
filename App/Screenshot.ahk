#Include <Abstractions\Mouse>

Class Screenshot {

    static exeTitle  := "ahk_exe ScreenClippingHost.exe"
    static winTitle  := "Screen Snipping " this.exeTitle
    static saveTitle := "Snip & Sketch ahk_exe ApplicationFrameHost.exe"

    static Start() => Send("#+s")
    static FullscreenOut() => Send("!{Printscreen}")

    ; static FullScreenOut() {
    ;    this.Start()
    ;    WinWaitActive(this.winTitle)
    ;    this.Fullscreen()
    ; }

    static Rectangle()  => Mouse.ClickThenGoBack("839 6")
    static Window()     => Mouse.ClickThenGoBack("959 6")
    static Fullscreen() => Mouse.ClickThenGoBack("1018 31")
}