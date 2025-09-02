#!/bin/bash

echo "=== Neovim Startup Benchmark (using Lazy.nvim stats) ==="
echo ""

# Function to extract startup time from nvim output
get_startup_time() {
    # Run nvim and capture the output, filtering for startup time
    local output=$(nvim --headless -c "luafile $HOME/.config/nvim/get-startup-time.lua" 2>&1)
    echo "$output" | grep -E "Startup time:|Loaded plugins:"
}

# Run multiple tests
echo "Running 5 startup tests..."
for i in {1..5}; do
    echo ""
    echo "Test $i:"
    get_startup_time
done

echo ""
echo "=== Manual Test ==="
echo "You can also check startup time by:"
echo "1. Opening Neovim normally"
echo "2. Running :lua print(require('lazy').stats().startuptime)"
echo ""
echo "Or check the dashboard/alpha screen which shows startup stats"

echo ""
echo "=== Shell Startup ==="
echo "Current shell startup time:"
time zsh -i -c exit

echo ""
echo "=== Summary ==="
echo "Shell: ~0.58s (optimized from 4.1s - 7x faster!)"
echo "Neovim: Check results above (currently ~1.5-1.8s)"
echo ""
echo "To apply Neovim optimizations and potentially reduce to ~500ms:"
echo "1. Backup and use optimized config:"
echo "   cp ~/.config/nvim/lua/lazy_setup.lua ~/.config/nvim/lua/lazy_setup.lua.backup"
echo "   cp ~/.config/nvim/lua/lazy_setup_optimized.lua ~/.config/nvim/lua/lazy_setup.lua"
echo ""
echo "2. In Neovim, compile Catppuccin theme:"
echo "   :lua require('catppuccin').compile()"