#! /bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install vimrc"
ln -s ~/dotfiles/bashrc ~/.bashrc 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install bashrc"
ln -s ~/dotfiles/chktexrc ~/.chktexrc 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install chktexrc"
ln -s ~/dotfiles/emacs ~/.emacs 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install emacs"
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install tmux.conf"
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install nvim/init.lua"
ln -s ~/dotfiles/zathura/zathurarc ~/.config/zathura/zathurarc 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install zathura/zathurarc"
ln -s ~/dotfiles/profile ~/.profile 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install profile"
ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf 2> /dev/null || echo -e "\e[31mError\e[0m: Failed to install kitty.conf"
