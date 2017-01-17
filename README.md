My dotfiles, script to symlink actual dotfiles to this directory, and some useful staff.

To pull with https but push with ssh:

`.git/config`

```
[remote "origin"]
        url = https://github.com/selivan/dotfiles.git
        pushurl = git@github.com:selivan/dotfiles.git
        fetch = +refs/heads/*:refs/remotes/origin/*
```

