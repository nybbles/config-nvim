#!/bin/bash

echo "=== Testing Optimized Neovim Startup Time ==="
echo ""

# Test startup time with timing
echo "Running 3 quick startup tests..."
for i in {1..3}; do
    echo -n "Test $i: "
    /usr/bin/time -f "%e seconds" nvim --headless +qa! 2>&1 | grep "seconds"
done

echo ""
echo "=== Manual Testing Instructions ==="
echo "1. Open Neovim normally: nvim"
echo "2. Check the dashboard - it should show startup time at the bottom"
echo "3. Or run: :lua print(string.format('%.2fms', require('lazy').stats().startuptime))"
echo ""
echo "Expected improvements:"
echo "- Previously: ~1.5-1.8 seconds"
echo "- Target: ~0.5-0.8 seconds"
echo ""
echo "=== Applied Optimizations ==="
echo "✓ Enhanced lazy_setup.lua performance settings"
echo "✓ Compiled Catppuccin theme"
echo "✓ Disabled term_colors in Catppuccin"
echo "✓ Lazy loaded LuaSnip (only loads on InsertEnter)"
echo "✓ Lazy loaded Telescope (only loads on command/keypress)"
echo "✓ Disabled octo.nvim plugin"
echo "✓ Lazy loaded presence.nvim"
echo "✓ Optimized nvim-navbuddy lazy loading"
echo "✓ Removed many unused RTP plugins"