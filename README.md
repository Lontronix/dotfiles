# Dotfiles

Configuration files that I use on my computers.

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
