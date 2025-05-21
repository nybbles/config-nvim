return {
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
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
      
      -- Add keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<leader>db", dap_python.test_method, { desc = "Debug Python: Test Method", buffer = true })
          vim.keymap.set("n", "<leader>dc", dap_python.test_class, { desc = "Debug Python: Test Class", buffer = true })
          vim.keymap.set("n", "<leader>dr", function() dap_python.test_method({strategy = "django"}) end, { desc = "Debug Python: Test Method (Django)", buffer = true })
        end,
      })
    end,
  },
  {
    "petobens/poet-v",
    ft = { "python" },
    config = function()
      -- Auto-activate environments
      vim.g.poetv_auto_activate = 1
      -- Show environment name in status line
      vim.g.poetv_set_environment = 1
    end
  },
  {
    "wookayin/semshi",
    ft = { "python" },
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