# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hache/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#####################
### USER STUFF(?) ###
#####################

# Exports
export EDITOR="/usr/local/bin/nvim"

# Aliases
alias ls='lsd'
alias la='lsd -A'
# alias cat='bat'

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
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
