return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crates").setup({
      smart_insert = true,
      insert_closing_quote = true,
      avoid_prerelease = true,
      autoload = true,
      autoupdate = true,
      loading_indicator = true,
      date_format = "%Y-%m-%d",
      thousands_separator = ",",
      notification_title = "Crates",
      curl_args = { "-sL", "--retry", "1" },
      max_parallel_requests = 80,
      open_programs = { "xdg-open", "open" },
      disable_invalid_feature_diagnostic = false,
      text = {
        loading = "   Loading",
        version = "   %s",
        prerelease = "   %s",
        yanked = "   %s",
        nomatch = "   No match",
        upgrade = "   %s",
        error = "   Error fetching crate",
      },
      highlight = {
        loading = "CratesNvimLoading",
        version = "CratesNvimVersion",
        prerelease = "CratesNvimPreRelease",
        yanked = "CratesNvimYanked",
        nomatch = "CratesNvimNoMatch",
        upgrade = "CratesNvimUpgrade",
        error = "CratesNvimError",
      },
      popup = {
        autofocus = false,
        hide_on_select = false,
        copy_register = '"',
        style = "minimal",
        border = "rounded",
        show_version_date = false,
        show_dependency_version = true,
        max_height = 30,
        min_width = 20,
        padding = 1,
        text = {
          title = " %s",
          pill_left = "",
          pill_right = "",
          description = "%s",
          created_label = " created        ",
          created = "%s",
          updated_label = " updated        ",
          updated = "%s",
          downloads_label = " downloads      ",
          downloads = "%s",
          homepage_label = " homepage       ",
          homepage = "%s",
          repository_label = " repository     ",
          repository = "%s",
          documentation_label = " documentation  ",
          documentation = "%s",
          crates_io_label = " crates.io      ",
          crates_io = "%s",
          categories_label = " categories     ",
          keywords_label = " keywords       ",
          version = "  %s",
          prerelease = " %s",
          yanked = " %s",
          version_date = "  %s",
          feature = "  %s",
          enabled = " %s",
          transitive = " %s",
          normal_dependencies_title = " Dependencies",
          build_dependencies_title = " Build dependencies",
          dev_dependencies_title = " Dev dependencies",
          dependency = "  %s",
          optional = " %s",
          dependency_version = "  %s",
          loading = "  ",
        },
        highlight = {
          title = "CratesNvimPopupTitle",
          pill_text = "CratesNvimPopupPillText",
          pill_border = "CratesNvimPopupPillBorder",
          description = "CratesNvimPopupDescription",
          created_label = "CratesNvimPopupLabel",
          created = "CratesNvimPopupValue",
          updated_label = "CratesNvimPopupLabel",
          updated = "CratesNvimPopupValue",
          downloads_label = "CratesNvimPopupLabel",
          downloads = "CratesNvimPopupValue",
          homepage_label = "CratesNvimPopupLabel",
          homepage = "CratesNvimPopupUrl",
          repository_label = "CratesNvimPopupLabel",
          repository = "CratesNvimPopupUrl",
          documentation_label = "CratesNvimPopupLabel",
          documentation = "CratesNvimPopupUrl",
          crates_io_label = "CratesNvimPopupLabel",
          crates_io = "CratesNvimPopupUrl",
          categories_label = "CratesNvimPopupLabel",
          keywords_label = "CratesNvimPopupLabel",
          version = "CratesNvimPopupVersion",
          prerelease = "CratesNvimPopupPreRelease",
          yanked = "CratesNvimPopupYanked",
          version_date = "CratesNvimPopupVersionDate",
          feature = "CratesNvimPopupFeature",
          enabled = "CratesNvimPopupEnabled",
          transitive = "CratesNvimPopupTransitive",
          normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
          build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
          dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
          dependency = "CratesNvimPopupDependency",
          optional = "CratesNvimPopupOptional",
          dependency_version = "CratesNvimPopupDependencyVersion",
          loading = "CratesNvimPopupLoading",
        },
        keys = {
          hide = { "q", "<esc>" },
          open_url = { "<cr>" },
          select = { "<cr>" },
          select_alt = { "s" },
          toggle_feature = { "<cr>" },
          copy_value = { "yy" },
          goto_item = { "gd", "K", "<C-LeftMouse>" },
          jump_forward = { "<c-i>" },
          jump_back = { "<c-o>", "<C-RightMouse>" },
        },
      },
      src = {
        insert_closing_quote = true,
        text = {
          prerelease = "  pre-release ",
          yanked = "  yanked ",
        },
        coq = {
          enabled = false,
          name = "crates.nvim",
        },
      },
      null_ls = {
        enabled = false,
        name = "crates.nvim",
      },
      lsp = {
        enabled = true,
        name = "crates.nvim",
        on_attach = function(client, bufnr) end,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
  specs = {
    {
      "AstroNvim/astroui",
      opts = function(_, opts)
        local get_hlgroup = require("astroui").get_hlgroup
        local comment = get_hlgroup("Comment")
        local string = get_hlgroup("String")
        local keyword = get_hlgroup("Keyword")
        local warning = get_hlgroup("DiagnosticWarn")
        local error = get_hlgroup("DiagnosticError")
        local info = get_hlgroup("DiagnosticInfo")
        
        opts.highlights.init = vim.tbl_deep_extend("force", opts.highlights.init or {}, {
          CratesNvimLoading = { fg = comment.fg, italic = true },
          CratesNvimVersion = { fg = info.fg },
          CratesNvimPreRelease = { fg = warning.fg },
          CratesNvimYanked = { fg = error.fg },
          CratesNvimNoMatch = { fg = error.fg },
          CratesNvimUpgrade = { fg = string.fg, bold = true },
          CratesNvimError = { fg = error.fg },
          
          -- Popup highlights
          CratesNvimPopupTitle = { fg = keyword.fg, bold = true },
          CratesNvimPopupPillText = { fg = string.fg },
          CratesNvimPopupPillBorder = { fg = comment.fg },
          CratesNvimPopupDescription = { fg = comment.fg },
          CratesNvimPopupLabel = { fg = keyword.fg },
          CratesNvimPopupValue = { fg = string.fg },
          CratesNvimPopupUrl = { fg = info.fg, underline = true },
          CratesNvimPopupVersion = { fg = info.fg },
          CratesNvimPopupPreRelease = { fg = warning.fg },
          CratesNvimPopupYanked = { fg = error.fg },
          CratesNvimPopupVersionDate = { fg = comment.fg },
          CratesNvimPopupFeature = { fg = string.fg },
          CratesNvimPopupEnabled = { fg = info.fg },
          CratesNvimPopupTransitive = { fg = comment.fg },
          CratesNvimPopupDependency = { fg = string.fg },
          CratesNvimPopupOptional = { fg = comment.fg },
          CratesNvimPopupDependencyVersion = { fg = info.fg },
          CratesNvimPopupLoading = { fg = comment.fg, italic = true },
        })
      end,
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        -- Crates keymaps (only active in Cargo.toml files)
        maps.n["<Leader>C"] = { desc = "📦 Crates" }
        maps.n["<Leader>Ct"] = { function() require("crates").toggle() end, desc = "Toggle extra crates.io info" }
        maps.n["<Leader>Cr"] = { function() require("crates").reload() end, desc = "Reload" }
        maps.n["<Leader>Cv"] = { function() require("crates").show_versions_popup() end, desc = "Show versions" }
        maps.n["<Leader>Cf"] = { function() require("crates").show_features_popup() end, desc = "Show features" }
        maps.n["<Leader>Cd"] = { function() require("crates").show_dependencies_popup() end, desc = "Show dependencies" }
        maps.n["<Leader>Cu"] = { function() require("crates").update_crate() end, desc = "Update crate" }
        maps.v["<Leader>Cu"] = { function() require("crates").update_crates() end, desc = "Update crates" }
        maps.n["<Leader>Ca"] = { function() require("crates").update_all_crates() end, desc = "Update all crates" }
        maps.n["<Leader>CU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade crate" }
        maps.v["<Leader>CU"] = { function() require("crates").upgrade_crates() end, desc = "Upgrade crates" }
        maps.n["<Leader>CA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" }
        maps.n["<Leader>CH"] = { function() require("crates").open_homepage() end, desc = "Open homepage" }
        maps.n["<Leader>CR"] = { function() require("crates").open_repository() end, desc = "Open repository" }
        maps.n["<Leader>CD"] = { function() require("crates").open_documentation() end, desc = "Open documentation" }
        maps.n["<Leader>CC"] = { function() require("crates").open_crates_io() end, desc = "Open crates.io" }
      end,
    },
  },
}