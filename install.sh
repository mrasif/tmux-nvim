#!/bin/bash

check_tmux() {
    if command -v tmux >/dev/null 2>&1; then
        echo "T-mux is already installed."
        return 0
    else
        echo "T-mux is not installed."
        return 1
    fi
}

install_tmux() {
    echo "Installing T-mux..."
    sudo apt install -y tmux
    
    if [ $? -eq 0 ]; then
        echo "T-mux installation successful."
    else
        echo "T-mux installation failed."
    fi
}

install_tmux_plugin_manager() {
    echo "Installing T-mux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Function to configure tmux and install a plugin
install_tmux_plugin() {
    local plugin=$1

    echo "Configuring tmux to use TPM and install plugin: $plugin"
    
    # Create a tmux configuration file if it doesn't exist
    if [ ! -f ~/.tmux.conf ]; then
        curl -o ~/.tmux.conf -L https://raw.githubusercontent.com/mrasif/tmux-nvim/main/.tmux.conf
    fi
   
    # Install script for CPU and RAM monitoring
    sudo mkdir /opt/scripts
    sudo curl -o /opt/scripts/cpu_info.sh -L https://raw.githubusercontent.com/mrasif/tmux-nvim/main/cpu_info.sh
    sudo curl -o /opt/scripts/ram_info.sh -L https://raw.githubusercontent.com/mrasif/tmux-nvim/main/ram_info.sh
    sudo curl -o /opt/scripts/utils.sh -L https://raw.githubusercontent.com/mrasif/tmux-nvim/main/utils.sh

    sudo chmod +x /opt/scripts/cpu_info.sh
    sudo chmod +x /opt/scripts/ram_info.sh
    sudo chmod +x /opt/scripts/utils.sh

    export PATH=$PATH:/opt/scripts

    # Install the plugin using TPM
    ~/.tmux/plugins/tpm/bin/install_plugins
}

check_neovim() {
    if command -v nvim >/dev/null 2>&1; then
        echo "Neo-VIM is already installed."
        return 0
    else
        echo "Neo-VIM is not installed."
        return 1
    fi
}

install_neovim() {
    echo "Installing Neo-VIM version 0.10..."
    curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
    tar xzf nvim-linux64.tar.gz
    sudo mv nvim-linux64 /usr/local/neovim-0.10
    sudo ln -s /usr/local/neovim-0.10/bin/nvim /usr/local/bin/nvim
    rm nvim-linux64.tar.gz
    nvim --version
    
    if [ $? -eq 0 ]; then
        echo "Neo-VIM installation successful."
    else
        echo "Neo-VIM installation failed."
    fi
}

clean_up_neovim() {
    echo "Cleaning up Neo-VIM..."
    rm -rf ~/.config/nvim
    mkdir ~/.config/nvim
    rm -rf ~/.local/share/nvim
}

install_neovim_plugins() {
    echo "Downloading and installing Neovim plugins..."
    mkdir -p ~/.config/nvim
    git clone https://github.com/mrasif/.nvim.git nvim
    mv nvim/* ~/.config/nvim
    rm -rf nvim
}

check_golang() {
    export PATH=$PATH:/usr/local/go/bin
    if command -v /usr/local/go/bin/go >/dev/null 2>&1; then
        echo "Go is already installed."
        return 0
    else
        echo "Go is not installed."
        return 1
    fi
}


install_golang() {
   # Define the Go version to install
    GO_VERSION="1.22.3"

    # Define the architecture (amd64, arm64, etc.)
    ARCH="$(dpkg --print-architecture)"

    # Define the download URL
    GO_URL="https://golang.org/dl/go$GO_VERSION.linux-$ARCH.tar.gz"

    # Define the installation directory
    INSTALL_DIR="/usr/local"

    # Download the Go binary using curl
    echo "Downloading Go $GO_VERSION..."
    sudo curl -LO "$GO_URL"

    # Extract the downloaded tarball
    echo "Extracting Go $GO_VERSION..."
    sudo tar -C "$INSTALL_DIR" -xzf "go$GO_VERSION.linux-$ARCH.tar.gz"

    # Remove the downloaded tarball
    echo "Cleaning up..."
    sudo rm "go$GO_VERSION.linux-$ARCH.tar.gz"

    # Verify the installation
    echo "Go installation completed. Verifying installation..."
    go version
}

install_golang_dependencies(){
    echo "Installing gopls and delve..."
    go install golang.org/x/tools/gopls@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
}

install_neovim_dependencies() {
    echo "Downloading lua-language-server..."
    sudo curl -o lua-language-server.tar.gz -L https://github.com/LuaLS/lua-language-server/releases/download/3.9.1/lua-language-server-3.9.1-linux-x64.tar.gz
    echo "Installing lua-language-server..."
    sudo mkdir /opt/lua-language-server
    sudo tar -xvf lua-language-server.tar.gz -C /opt/lua-language-server
    if [ $? -eq 0 ]; then
        echo "lua-language-server installation successful."
    else
        echo "lua-language-server installation failed."
    fi
    sudo rm lua-language-server.tar.gz
}

export_env() {
    export GOPATH=$HOME/go
    export GOROOT=/usr/local/go
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOPATH
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:$GOBIN
    export PATH=$PATH:/opt/lua-language-server/bin
}

print_export_env() {
    echo "Export these environment variables to ~/.bashrc..."
    echo 'export PATH=$PATH:/opt/scripts'
    echo 'export GOPATH=$HOME/go'
    echo 'export GOROOT=/usr/local/go'
    echo 'export GOBIN=$GOPATH/bin'
    echo 'export PATH=$PATH:$GOPATH'
    echo 'export PATH=$PATH:$GOROOT/bin'
    echo 'export PATH=$PATH:$GOBIN'
    echo 'export PATH=$PATH:/opt/lua-language-server/bin'
}

echo "Updating package list..."
sudo apt update
    
echo "Installing curl ripgrep gcc"
sudo apt install -y curl ripgrep gcc
    


if ! check_tmux; then
    install_tmux
fi

install_tmux_plugin_manager
clean_up_neovim
install_tmux_plugin

if ! check_neovim; then
    install_neovim
fi

clean_up_neovim
install_neovim_plugins
install_neovim_dependencies
if ! check_golang; then
    install_golang
fi
install_golang_dependencies

export_env
print_export_env
