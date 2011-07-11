#!/bin/bash
# fedora installations 
su -c "yum install -y tmux weechat vim namei git xterm fpaste ack" 
# vim configutation
cp ./.vimrc ~/
cp ./.vim/funclist.txt ~/
mkdir ~/.vim
cp -rf ./.vim/* ~/.vim
# xterm configuration
cp ./.Xresources ~/
xrdb -merge ~/.Xresources
# tmux config
cp ./.tmux.conf ~/
