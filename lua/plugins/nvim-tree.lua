return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
    vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus left' })
    vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus right' })


    -- Jump specifically to the NvimTree window
    vim.keymap.set('n', '<leader>ft', ':NvimTreeFocus<CR>', { desc = 'Focus NvimTree' })

    -- Reveal the location of the currently open file in the tree view
vim.keymap.set('n', '<leader>gf', ':NvimTreeFindFile<CR>', { desc = 'Find current file in Tree' })

  -- Open the NvimTree when launching Neovim if no file is specified
    vim.cmd([[
  autocmd VimEnter * if !argc() | NvimTreeOpen | endif
]])

  end,
}
