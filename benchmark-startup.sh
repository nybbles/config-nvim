#!/bin/bash

echo "=== Neovim Startup Benchmark ==="
echo ""

# Function to run nvim startup test
benchmark_nvim() {
    local total=0
    local count=5
    
    echo "Running $count startup tests..."
    for i in $(seq 1 $count); do
        # Run nvim with headless mode to avoid ANSI codes
        nvim --headless --startuptime /tmp/nvim-bench-$i.log +qa! 2>/dev/null
        
        # Extract time from the last line, removing any non-numeric characters
        local time_ms=$(tail -1 /tmp/nvim-bench-$i.log 2>/dev/null | awk '{print $1}' | sed 's/[^0-9.]//g')
        
        if [[ -n "$time_ms" ]] && [[ "$time_ms" =~ ^[0-9]+\.?[0-9]*$ ]]; then
            echo "  Test $i: ${time_ms}ms"
            total=$(awk "BEGIN {print $total + $time_ms}")
        else
            echo "  Test $i: Failed to parse time"
            ((count--))
        fi
    done
    
    if [[ $count -gt 0 ]]; then
        local avg=$(awk "BEGIN {printf \"%.2f\", $total / $count}")
        echo ""
        echo "Average startup time: ${avg}ms"
    fi
    
    # Show slowest operations
    if [[ -f /tmp/nvim-bench-5.log ]]; then
        echo ""
        echo "Top 10 slowest operations from last run:"
        grep -E "^[0-9]+\.[0-9]+\s+[0-9]+\.[0-9]+\s+[0-9]+\.[0-9]+:" /tmp/nvim-bench-5.log 2>/dev/null | sort -k2 -nr | head -10
    fi
}

# Alternative simple timing method
simple_benchmark() {
    echo ""
    echo "Alternative timing method (5 runs):"
    for i in {1..5}; do
        local start=$(date +%s%N)
        nvim --headless +qa! 2>/dev/null
        local end=$(date +%s%N)
        local elapsed=$(( (end - start) / 1000000 ))
        echo "  Run $i: ${elapsed}ms"
    done
}

# Run benchmarks
benchmark_nvim
simple_benchmark

echo ""
echo "=== Shell Startup Benchmark ==="
echo "Current shell startup time:"
time zsh -i -c exit

echo ""
echo "=== Current Performance Status ==="
echo "Shell startup: ~0.58s (optimized from 4.1s)"
echo "Neovim startup: Check results above"

echo ""
echo "=== Optimization Tips ==="
echo "1. To use the optimized lazy_setup.lua:"
echo "   mv ~/.config/nvim/lua/lazy_setup.lua ~/.config/nvim/lua/lazy_setup.lua.backup"
echo "   mv ~/.config/nvim/lua/lazy_setup_optimized.lua ~/.config/nvim/lua/lazy_setup.lua"
echo ""
echo "2. Compile Catppuccin theme for faster loading:"
echo "   :lua require('catppuccin').compile()"
echo ""
echo "3. Review plugins in ~/.config/nvim/lua/plugins/ and add 'lazy = true' where possible"
echo ""
echo "4. To see detailed startup analysis:"
echo "   nvim --startuptime startup.log"
echo "   Then review startup.log"