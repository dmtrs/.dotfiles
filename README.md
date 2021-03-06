# .dotfiles

Install [rcm](https://github.com/thoughtbot/rcm)

TLDR; macOs
```
brew tap thoughtbot/formulae
brew install rcm
```

## Setup

Clone this repository:
```
git clone git@github.com:dmtrs/.dotfiles.git ~/.dotfiles
```

The directory `~/.dotfiles` only contains rc files; and these rc filenames do not begin with a period.

Dry run with lsrc(1). Look for anything unexpected in here, such as ~/.install or ~/.Makefile, or an empty list of dotfiles.
```
lsrc
```
Update any symlinks with rcup(1). This is likely to do nothing, since your dotfiles already exist.
```
rcup -v
```
When necessary, add new rc files to the dotfiles directory with mkrc(1).
```
mkrc ~/.tigrc
```
In the other direction, you can use rcup(1) to create the symlinks from ~/.dotfiles to your home directory.
```
rcup tigrc
```



