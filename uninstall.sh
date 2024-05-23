#!/bin/bash

uninstall_tmux() {
    echo "Uninstalling T-mux..."
    sudo apt remove -y tmux
    rm -rf ~/.tmux
    rm ~/.tmux.conf
    sudo rm -rf /opt/scripts
}

uninstall_neovim() {
    echo "Uninstalling Neovim..."
    sudo rm /usr/local/bin/nvim
    sudo rm -rf /usr/local/neovim-0.10
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    sudo rm -rf /opt/lua-language-server
}

uninstall_tmux
uninstall_neovim
sudo apt autoremove -y
