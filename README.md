# Dotfiles

Configuration files that I use on my computers.

![hydrogen-frame](https://user-images.githubusercontent.com/31291523/103188818-f1dd3600-4897-11eb-84bd-05d8cf9eb552.png)

## Installation Guide
### hostname
- create a file called .hostname and set the HOSTNAME enviorment variable.

		export HOSTNAME="<hostname>"

### Git
- On the new machine created ~/.gitconfig if it does not already exist. Add the     following:

		[user]
			name = Lonnie Gerol
			email = ...
		[include]
			path = ~/dotfiles/git/gitconfig

### Homebrew
- To install apps and packages in Brewfile navigate to dotfiles directory and
  run 
	
		brew bundle

### VSCode
- key repeat

		defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

### Misc macOS Config
- To enable key repeat run
	
		defaults write -g ApplePressAndHoldEnabled -bool false

