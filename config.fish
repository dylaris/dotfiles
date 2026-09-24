if status is-interactive
    # Commands to run in interactive sessions can go here
end

function nook
    lua /home/dylaris/programing/nook/nook.lua $argv
end

set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8

set -gx PATH $HOME/opt/tatr/build $HOME/.cargo/bin/ $HOME/opt/sakuracat-1.3.5/ $HOME/opt/vscode/bin $HOME/opt/vnote/ $HOME/opt/neovide/ $HOME/opt/mupdf/bin $HOME/opt/nvim-linux-x86_64/0.11/bin $PATH

set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
set -gx RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup

set -gx GITHUB_PROXY https://gh.bugdey.us.kg

setxkbmap -option ctrl:nocaps

# Created by `pipx` on 2026-08-30 09:24:38
set PATH $PATH /home/dylaris/.local/bin
