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
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export EDITOR=/usr/bin/nvim
export DOTNET_ROOT=$HOME/.dotnet
export BAT_THEME="Tomorrow-Night"

# Aliases
# WARN: Below alias will ensure any other aliases are expanded with sudo. Security risk.
alias sudo="sudo "
alias doas="doas "

alias xr="xbps-remove -R"
alias fp="flatpak"
alias py="python3"

# Conditional Aliases

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza --icons -l --group-directories-first"
  alias la="eza --icons -A --group-directories-first"
  alias lla="eza --icons -lA --group-directories-first"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat -p"
fi

# Keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word
# key setup for caveman-brained terminal workflow using tmux

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
# NOTE: do I put this at the very end, or before TMUX?
export STARSHIP_CONFIG="$HOME/.config/starship/zsh.toml"
eval "$(starship init zsh)"

####################
### TMUX SESSION ###
####################

session_name="default"
setopt ignoreeof

detach_on_eof() {
  num_open_panes=$(tmux list-panes -t "$session_name" | wc -l)
  num_open_windows=$(tmux list-windows -t "$session_name" | wc -l)
  if [[ $num_open_panes == 1 && $num_open_windows == 1 && -z "$TOGGLETERM" ]]; then
    tmux detach
  else
    exit
  fi
}
zle -N detach_on_eof

exit_on_eof() {
  exit
}
zle -N exit_on_eof

if [[ -n "$TMUX" ]]; then
  bindkey "^D" detach_on_eof
else
  bindkey "^D" exit_on_eof
fi

if [[ -z "$TMUX" ]]; then
  if tmux has-session -t "$session_name" 2>/dev/null; then
    num_clients=$(tmux list-clients -t "$session_name" | wc -l)
    if [[ $num_clients -eq 0 ]]; then
      exec tmux attach-session -t "$session_name"
    fi
  else
    exec tmux new-session -s "$session_name"
  fi
fi
