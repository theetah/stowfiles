if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fishconf
    nvim ~/.config/fish/config.fish
end

function kittyconf
    nvim ~/.config/kitty/kitty.conf
end

function starconf
    nvim ~/.config/starship/starship.toml
end

alias fp "flatpak"
alias py "python3"
# alias ls "lsd"
# alias la "lsd -A"
# alias lsa "lsd -lA"
# alias cat "bat"
# alias helix "hx"
# alias mint "env -u WAYLAND_DISPLAY /usr/bin/"

set fish_greeting ''
set -gx EDITOR /usr/local/bin/nvim

# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml:$HOME/.config/starship/fish.toml"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export BAT_THEME="Tomorrow-Night"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk/"

starship init fish | source
