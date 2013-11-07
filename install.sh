#!/bin/bash

# link the vimrc to ~/.vimrc
ln -f -s ~/.vim/vimrc ~/.vimrc
ln -f -s ~/.vim/gvimrc ~/.gvimrc

# Install vundle first
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install plugins
vim +BundleInstall +qall
