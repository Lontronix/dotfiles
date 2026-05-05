# dotfiles

Managed with [chezmoi](https://chezmoi.io).

## Setup

### Prerequisites

#### Homebrew
Make sure [HomeBrew](https://brew.sh) is installed.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#### Oh-my-zsh

Make sure [Oh-my-zsh](https://ohmyz.sh/) is installed.

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Using Chezmoi

```
chezmoi init --source ~/Developer/Source.dev/dotfiles
```

Then apply the dotfiles:

```
chezmoi apply
```

## Defaults Customization

### Disable Press and Hold

```
defaults write -g ApplePressAndHoldEnabled -bool false
```

### Key Repeat Delay
Note: The normal value is `15` (225 ms)

```
defaults write -g InitialKeyRepeat -int 10
```

### Key Repeat Speed
Note: the normal value is `2` (30 ms)

```
defaults write -g KeyRepeat -int 1
```

## Notes

If this repo is not cloned to the default chezmoi location (`~/.local/share/chezmoi`), the `--source <path>` flag must be passed to every chezmoi command.
