# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hache/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

############################
### PLUGIN MANAGER SETUP ###
############################

if ! command -v git >/dev/null 2>&1; then
  echo "WARNING: git is not installed! git is needed for plugin management; .zshrc exiting."
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

###################
### USER CONFIG ###
###################

# Exports
export PATH=$HOME/.local/bin:$PATH
export BAT_THEME="Tomorrow-Night"
export EDITOR="/usr/bin/nvim"

# Aliases
# WARN: Below alias will ensure any other aliases are expanded with sudo. Security risk.
alias sudo="sudo "
alias doas="doas "

alias xr="xbps-remove -R"
alias fp="flatpak"
alias py="python3"

# Conditional Aliases

if command -v lsd >/dev/null 2>&1; then
  alias ls="lsd"
  alias la="lsd -A"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat -p"
fi

# Keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Miscellaneous
autoload -U select-word-style
select-word-style bash

##############
### TWEAKS ###
##############

# small tweak to zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'

# ensure ls-deluxe gets correct colors
eval "$(dircolors)"

################
### STARSHIP ###
################

# uncomment when starship supports multiple config files
# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:-$HOME/.config/starship/zsh.toml"
export STARSHIP_CONFIG="$HOME/.config/starship/zsh.toml"
eval "$(starship init zsh)"

####################
### TMUX SESSION ###
####################

# This snippet allows the shell to be attached to the session,
# effectively, Ctrl+D will close the window like normal, but we now have sessions!

# if command -v tmux &>/dev/null; then
#     if [ -z "$TMUX" ]; then  # Not already inside tmux
#         session_name="default"
#         # Attach if session exists; otherwise, create new session
#         if tmux has-session -t "$session_name" 2>/dev/null; then
#             exec tmux attach-session -t "$session_name"
#         else
#             exec tmux new-session -s "$session_name"
#         fi
#     fi
# fi
