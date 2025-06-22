#!/bin/bash

# Neovim Auto Theme Script
# Monitors GNOME color scheme changes and updates all running Neovim instances

interface="org.freedesktop.portal.Settings"
monitor_path="/org/freedesktop/portal/desktop"
monitor_member="SettingChanged"
count=0

# Function to update Neovim instances
update_neovim_theme() {
    local theme=$1
    
    # Find all Neovim server sockets
    local nvim_sockets=($(find /tmp -name "nvim.*" -type d 2>/dev/null))
    
    for socket_dir in "${nvim_sockets[@]}"; do
        local socket_file=$(find "$socket_dir" -name "*.sock" 2>/dev/null | head -n 1)
        if [[ -S "$socket_file" ]]; then
            if [[ "$theme" == "dark" ]]; then
                nvim --server "$socket_file" --remote-send ':lua vim.g.catppuccin_flavour = "mocha"; vim.o.background = "dark"; vim.cmd.colorscheme("catppuccin")<CR>' 2>/dev/null
            else
                nvim --server "$socket_file" --remote-send ':lua vim.g.catppuccin_flavour = "latte"; vim.o.background = "light"; vim.cmd.colorscheme("catppuccin")<CR>' 2>/dev/null
            fi
        fi
    done
}

# Initial theme detection and application
initial_theme="$(gsettings get org.gnome.desktop.interface color-scheme)"
if [[ "$initial_theme" == "'prefer-dark'" ]]; then
    update_neovim_theme "dark"
else
    update_neovim_theme "light"
fi

# Monitor for changes
dbus-monitor --profile "interface='$interface',path=$monitor_path,member=$monitor_member" |
    while read line; do
        let count++
        
        if [ $count = 3 ]; then
            theme="$(gsettings get org.gnome.desktop.interface color-scheme)"
            if [[ "$theme" == "'prefer-dark'" ]]; then
                update_neovim_theme "dark"
            else
                update_neovim_theme "light"
            fi
            count=0
        fi
    done