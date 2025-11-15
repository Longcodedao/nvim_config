return {
  -- LSP Configuration Manager (CRUCIAL for your setup)
  { 'neovim/nvim-lspconfig' },

  -- LSP Installer (Makes installing pyright/ruff easier)
  { 'williamboman/mason.nvim', config = true }, -- The installer GUI
  
  -- Bridges mason.nvim and nvim-lspconfig
  { 'williamboman/mason-lspconfig.nvim' },

  -- Autocompletion Engine
  { 'hrsh7th/nvim-cmp' },
  
  -- LSP Source for nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' },
}

