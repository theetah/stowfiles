if status is-interactive
    # Commands to run in interactive sessions can go here
end

###################
### USER CONFIG ###
###################

alias fp "flatpak"
alias py "python3"
alias ls "lsd"
alias la "lsd -A"
alias lsa "lsd -lA"
alias cat "bat"
alias mint "env -u WAYLAND_DISPLAY /usr/bin/"

set fish_greeting ''
set -gx EDITOR /usr/local/bin/nvim

# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:$HOME/.config/starship/fish.toml"
export BAT_THEME="Tomorrow-Night"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk/"

export STARSHIP_CONFIG="$HOME/.config/starship/fish.toml"
starship init fish | source
