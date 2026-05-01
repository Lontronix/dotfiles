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

## Notes

If this repo is not cloned to the default chezmoi location (`~/.local/share/chezmoi`), the `--source <path>` flag must be passed to every chezmoi command.
