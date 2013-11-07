#!/bin/bash

# link the vimrc to ~/.vimrc
ln -s ~/.vim/vimrc ~/.vimrc

# Install vundle first
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install plugins
vim +BundleInstall +qall
