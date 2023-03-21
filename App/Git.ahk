#Include <Paths>
#Include <Tools\Info>
#Include <Abstractions\Text>
#Include <Utils\Cmd>
#Include <Loaders\Links>

Class Git {

    __New(workingDir) {
        this.shell := Cmd(workingDir)
    }


    shell := unset
    commands := []


    Add(files*) {
        sFiles := this._GetFilesString(files)
        this.commands.Push("git add " sFiles)
        return this
    }

    Commit(message) {
        this.commands.Push('git commit -m "' message '"')
        return this
    }

    Push() {
        this.commands.Push("git push")
        return this
    }

    Execute() {
        this.shell.Execute(this.commands*)
        this.commands := []
        return this
    }


    _GetFilesString(files) {
        sFiles := ""
        if !files.Length {
            return "."
        }
        for index, filePath in files {
            sFiles .= '"' filePath '" '
        }
        return sFiles
    }


    /**
    * Specify a file path and get the github link for it
    * @param path *String* Path to the file / folder you want the link to. In Main/Folder/file.txt, Main is the name of the repo (so the path is relative to your gh profile, basically)
    * @returns {String} the github link
    */
    static Link(path) {
        static github := Links["ghm"] ;Specify you github link (https://github.com/yourNickname/)
        static fileBlob := "/blob/main/" ;The part between the name of the repo and the other file path is different depending on whether it's a file or a folder
        static folderBlob := "/tree/main/"

        path := StrReplace(path, "\", "/") ;The link uses forward slashes, this replace is made so you can use whatever slashes you feel like

        if InStr(path, "C:/Programming/")
            path := StrReplace(path, "C:/Programming/") ;For the if I specify the full path, ignore this, will be removed in the public release of the function

        if !InStr(path, "/") ;You can just specify the name of the repo to get a link for it
            return github path

        if !RegExMatch(path, "\/$") && RegExMatch(path, "\.\w+$") ;If the passed path ends with a /, it will be considered a path to a folder. If the passed path ends with a `.extension`, it will be considered a file
            currentBlob := fileBlob
        else
            currentBlob := folderBlob

        RegExMatch(path, "([^\/]+)\/(.*)", &match) ;Everything before the first / will be considered the name of the repo. Everything after - the relative path in this repo
        repo := match[1]
        relPath := match[2]

        github_link := StrReplace(github repo currentBlob relPath, " ", "%20")
        return github_link
    }

    static InstallAhkLibrary(link, fileName?) {
        static libFolder := Paths.Lib "\"
        link := StrReplace(link, "https://github.com/")
        link := StrReplace(link, "blob/",,,, 1)
        file_html := GetHtml("https://raw.githubusercontent.com/" link)
        if !IsSet(fileName) {
            RegExMatch(link, "\/([^.\/]+\.\w+)$", &match)
            newFile := match[1]
        }
        else {
            newFile := fileName
        }
        WriteFile(libFolder newFile, file_html)
        Info(newFile " library installed in: " libFolder)
    }

}