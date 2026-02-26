# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hache/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###################
### USER CONFIG ###
###################

# Exports
export PATH=$HOME/.local/bin:$PATH
export BAT_THEME="Tomorrow-Night"
export EDITOR="/usr/local/bin/nvim"

# Aliases
# Ordinary aliases to be added :p

# Conditional Aliases

# Considering whether or not to put this here or at exports
export ALIAS_WARNINGS=true

# Only works for very limited scenarios
# i.e. cannot alias "ls" to "lsd -A"
alias_if_exists () {
  if command -v "$2" >/dev/null 2>&1; then
    alias "$1"="$2"
  elif [[ "$ALIAS_WARNINGS" == true ]]; then
    echo "command $2 DNE"
  fi
}

# You can technically not use quotation marks,
# but I think this makes it look a lot neater.

# Note: below won't work on Ubuntu-based systems, due to package naming.
alias_if_exists "cat" "bat"
alias_if_exists "fp" "flatpak"

# You do not want to implement array logic in
# the alias_if_exists function. Trust me.
if command -v lsd >/dev/null 2>&1; then
  alias ls="lsd"
  alias la="lsd -A"
fi

# Keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Miscellaneous
autoload -U select-word-style
select-word-style bash

############################
### PLUGIN MANAGER SETUP ###
############################

if ! command -v git >/dev/null 2>&1; then
  echo "WARNING: git is not installed! git is needed for plugin management. .zshrc exiting."
  exit 1
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Install plugin manager if it doesn't exist on the system
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load plugin manager
source "${ZINIT_HOME}/zinit.zsh"

###############
### PLUGINS ###
###############

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

#####################
### PLUGIN TWEAKS ###
#####################

# small tweak to zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'

################
### STARSHIP ###
################

# uncomment when starship supports multiple config files
# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:-$HOME/.config/starship/zsh.toml"
export STARSHIP_CONFIG="$HOME/.config/starship/zsh.toml"
eval "$(starship init zsh)"
