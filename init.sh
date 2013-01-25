#!/bin/bash
# fedora installations 
su -c "yum install -y tmux weechat vim namei fpaste ack git" 
git clone http://github.com/dmtrs/linux.conf
# vim configutation
cp ./linux.conf/.vimrc ~/
cp ./linux.conf/.vim/funclist.txt ~/
if [ ! -d ~/.vim ]
then   
    mkdir ~/.vim
fi    
cp -rf ./linux.conf/.vim/* ~/.vim
# tmux config
cp ./.tmux.conf ~/
