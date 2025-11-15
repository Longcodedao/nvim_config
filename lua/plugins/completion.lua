return {
  -- ... (Your existing LSP and CMP plugins can stay in lsp.lua or be merged here)

  -- New: Sources for nvim-cmp
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },

  -- New: Snippet Engine
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },

  -- The core CMP configuration block
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Ensure all sources are listed here
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    -- **Configuration goes here (see next section)**
    config = function()
      require("config.cmp_setup")
    end, 
  },
}
