# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

alias la="ls -A"
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gf="git fetch"
alias gpl="git pull"
alias gps="git push"
alias gst="git stash"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

bind '"\C-d"': ""

# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:$HOME/.config/starship/bash.toml"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#bbbbbb,fg+:#dddddd,bg:#1f1f1f,bg+:#242424
  --color=hl:#90bee1,hl+:#bed6ff,info:#676767,marker:#a1e6e0
  --color=prompt:#beda78,spinner:#ff93b3,pointer:#beda78,header:#87afaf
  --color=border:#474747,label:#bbbbbb,query:#cccccc'
eval "$(starship init bash)"

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
