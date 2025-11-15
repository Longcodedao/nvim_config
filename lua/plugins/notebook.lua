return {
  -- 1. THE CORE RUNNER & DEPENDENCIES
  {
    "benlubas/molten-nvim",
    -- Automatically set up dependencies to load together
    dependencies = {
      "3rd/image.nvim",
      "quarto-dev/quarto-nvim",
      "GCBallesteros/jupytext.nvim",
    },
    -- Load only when editing Python, Markdown, or Quarto files (common notebook filetypes)
    lazy = false,
    ft = { "python", "markdown", "quarto", "quarto-ipynb" },

    build = ":UpdateRemotePlugins",
    init = function() 
        -- Configuration via global variables (Your preferred method)
      
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = true
      vim.g.molten_output_virt_lines = true
      vim.g.molten_output_win_max_height = 20

      vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>",
    { silent = true, desc = "molten delete cell" })
      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",
          { silent = true, desc = "hide output" })
      vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
          { silent = true, desc = "show/enter output" })
          end, 

    -- Recommended: Set up keymaps for quick cell execution
    keys = {
      { "<localleader>mi", "<Cmd>MoltenInit<CR>", desc = "Molten: Initialize Plugin (Local)" },
      { "<localleader>e", "<Cmd>MoltenEvaluateOperator<CR>", desc = "Molten: Evaluate Selection (Operator)" },
      { "<localleader>rl", "<Cmd>MoltenEvaluateLine<CR>", desc = "Molten: Evaluate Current Line" },
      { "<localleader>rr", "<Cmd>MoltenReevaluateCell<CR>", desc = "Molten: Re-evaluate Cell" },
      { "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "Molten: Evaluate Visual Selection" },

      { "<localleader>mx", ":MoltenOpenInBrowser<CR>", desc = "open output in browser"}
    },
  }, 

  ---

  -- 2. IMAGE RENDERING
  {
    "3rd/image.nvim",
    -- Ensure you configure the correct backend for your terminal
    opts = {
      -- Options: "kitty", "iterm", "sixel", "w3m", or "auto"
      backend = "kitty", -- Set to sixel as requested

      -- Since you are on Ubuntu using ImageMagick
      processor = "magick_cli",

      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup", -- or "inline"
          floating_windows = false, -- if true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      scale_factor = 1.0,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    }
  },

  ---

  -- 3. JUPYTEXT CONVERSION (Required for plain-text editing)
  {
    "GCBallesteros/jupytext.nvim",
    ft = { "ipynb" }, -- Only load for .ipynb files
    config = function()
      require("jupytext").setup({
        -- When you open an .ipynb file, it will automatically open its paired
        -- plain-text version (a Python script with # %% cell markers).
        default_extension = "py",
      })
    end,
  },

  ---

  -- 4. QUARTO-NVIM (Provides LSP/Syntax/Code Running for code chunks)
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" , "md", "rmd"},
    config = function()
      require("config.quarto")
    end,
  },
}
