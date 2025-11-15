vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.cursorline = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.g.python3_host_org = "/usr/bin/python3"
require("config.lazy")

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },

  sync_root_with_cwd = true,
})

vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
require("lsp")


vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = {'*.py'},
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
