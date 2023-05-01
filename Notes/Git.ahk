Notes_Git := [

    ;; Github

    "gh repo fork",
    "gh repo fork [username]/[repository] --clone",

    ;; Git

    "git stash", "
    (
        git stash
        git stash pop
        git stash save name
        git stash list
        git stash apply indexNumber
    )",

    "git change the name of a branch",
    "git branch -m oldName newName",

    "git change the name of the current branch",
    "git branch -M newName",

    "git restore code to the state of the remote repo", "
    (
        git fetch origin
        git reset --hard origin/main
    )",

    "git change your email",
    "git config --global user.email some_other_address",

    "git log a specific file -p",
    "git log -p file",

    "git new branch",
    "git checkout -b branch-name",

    "git merge when on the master branch",
    "git merge branch-name",

    "git squash merge",
    "git merge branch-name --squash",

    "git push a pull request",
    "git push upstream branch-name",

    "git how to not have to put in your credentials all the time",
    "git config --global credential.helper store",

    "git change the default main master branch name",
    "git config --global init.defaultBranch main",

    "git sync the credential manager",
    "git config --global credential.helper '/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe'",

    "git add remote to the current directory",
    "git remote add origin https://github.com/userName/repo.git",

    "git pick the upstream branch for future pushes and push to it",
    "git push -u origin main",
]