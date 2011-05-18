#!/bin/bash
# fedora installations 
su -c "yum install -y tmux weechat vim namei git" 
# vim configutation

# xterm configuration
cp ./.Xresources ~/
xrdb -merge ~/.Xresources
