return {
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python", "quarto" },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local has_dap_python, dap_python = pcall(require, "dap-python")
      if not has_dap_python then
        return
      end
      
      -- Setup venv detection for better package navigation
      local venv_path = os.getenv("VIRTUAL_ENV")
      local conda_path = os.getenv("CONDA_PREFIX")
      
      if venv_path then
        dap_python.setup(venv_path .. "/bin/python")
      elseif conda_path then
        dap_python.setup(conda_path .. "/bin/python")
      else
        dap_python.setup("python")
      end
      
      -- Configure remote attach
      local dap = require('dap')
      
      -- Add Python remote attach configuration
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'attach',
        name = 'Remote Attach (prompt for port)',
        host = function()
          local host = vim.fn.input('Host [127.0.0.1]: ')
          if host == '' then return '127.0.0.1' end
          return host
        end,
        port = function()
          local port = vim.fn.input('Port: ')
          return tonumber(port)
        end,
      })
      
      -- Add keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"python", "quarto"},
        callback = function()
          -- Essential DAP controls
          vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: Start/Continue", buffer = true })
          vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Debug: Step Over", buffer = true })
          vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: Step Into", buffer = true })
          vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, { desc = "Debug: Step Out", buffer = true })
          vim.keymap.set("n", "<leader>dx", function() dap.terminate() end, { desc = "Debug: Terminate", buffer = true })
          
          -- Breakpoint management
          vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint", buffer = true })
          vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Debug: Set Conditional Breakpoint", buffer = true })
          vim.keymap.set("n", "<leader>dC", function() dap.clear_breakpoints() end, { desc = "Debug: Clear All Breakpoints", buffer = true })
          
          -- Python-specific
          vim.keymap.set("n", "<leader>dt", dap_python.test_method, { desc = "Debug Python: Test Method", buffer = true })
          vim.keymap.set("n", "<leader>dT", dap_python.test_class, { desc = "Debug Python: Test Class", buffer = true })
          vim.keymap.set("n", "<leader>da", function()
            -- Find and run the remote attach configuration
            for _, config in ipairs(dap.configurations.python) do
              if config.name == 'Remote Attach (prompt for port)' then
                dap.run(config)
                break
              end
            end
          end, { desc = "Debug Python: Remote Attach", buffer = true })
        end,
      })
    end,
  },
  {
    "petobens/poet-v",
    ft = { "python", "quarto" },
    config = function()
      -- Auto-activate environments
      vim.g.poetv_auto_activate = 1
      -- Show environment name in status line
      vim.g.poetv_set_environment = 1
    end
  },
  {
    "wookayin/semshi",
    ft = { "python", "quarto" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- Better highlighting for Python
      vim.g.semshi_no_default_rules = false
      vim.g.semshi_excluded_hl_groups = { 'pythonComment', 'pythonError' }
      vim.g.semshi_mark_selected_nodes = 1
      vim.g.semshi_error_sign = false
      vim.g.semshi_mark_global_variables = 1
      vim.g.semshi_excluded_filetypes = { 'python_test' }
      vim.g.semshi_nb_of_cpu_cores = 4
      vim.g.semshi_no_special_syntax_for_imported_objects = false
      vim.g.semshi_simplify_markup = false
    end,
  },
}