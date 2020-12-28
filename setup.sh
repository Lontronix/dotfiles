#!/bin/bash

rm -f ~/.p10k.zsh 						     # removing zshrc if it exists
ln -sf ~/dotfiles/zsh/p10k.zsh ~/.p10k.zsh   # powerline customization file
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc         # zshrc
ln -sf ~/dotfiles/bin ~/                     # scripts
ln -sf ~/dotfiles/vimrc ~/.vimrc             # vimrc 
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf     # tmux.conf
ln -sf ~/dotfiles/yabairc ~/.yabairc         # yabairc
ln -sf ~/dotfiles/skhdrc ~/.skhdrc           # skhdrc
# ln -sf ~/dotfiles/git/.gitconfig ~/      	 # gitconfig
 
# installing powerlevel 10k
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh}/themes/powerlevel10k ]
then
	echo "Installing powerlevel 10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh}/themes/powerlevel10k
else
	echo "powerlevel 10k already installed"
fi

# installing lightline
if [ ! -d ~/.vim/pack/plugins/start/lightline ]
then
	echo "Installing Lightline..."
	git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
else
	echo "lightline already installed"
fi
 
