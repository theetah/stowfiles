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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

alias la="ls -A"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:$HOME/.config/starship/bash.toml"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init bash)"

# This snippet allows the shell to be attached to the session,
# effectively, Ctrl+D will close the window like normal, but we now have sessions!
if command -v tmux &>/dev/null; then
    if [ -z "$TMUX" ]; then  # Not already inside tmux
        session_name="main"
        
        # Attach if session exists; otherwise, create new session
        if tmux has-session -t "$session_name" 2>/dev/null; then
            exec tmux attach-session -t "$session_name"
        else
            exec tmux new-session -s "$session_name"
        fi
    fi
fi
