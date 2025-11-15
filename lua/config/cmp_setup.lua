local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')


-- Recommended setting for completeopt
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
  -- The snippet engine to use (e.g., luasnip)
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Key mappings for navigating and confirming completion
  mapping = cmp.mapping.preset.insert({
    -- Completion Item Navigation
    ['<C-n>'] = cmp.mapping.select_next_item(),  -- Select NEXT completion item
    ['<C-p>'] = cmp.mapping.select_prev_item(),  -- Select PREVIOUS completion item
    
    -- documentation Scrolling
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll backward
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll forward

    -- Action
    ['<C-Space>'] = cmp.mapping.complete(),  -- Manually trigger completion
    ['<C-e>'] = cmp.mapping.abort(),         -- Close completion menu
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
  }),

  -- Define the completion sources and their order/priority
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- LSP completions
    { name = 'luasnip' },     -- Snippets
    { name = 'buffer' },      -- Words from the current buffer
    { name = 'path' },        -- File/path completions
  }),

  -- Optional: Appearance/window settings
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- 2. Tell cmp to run the autopairs handler after confirming a completion
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({ 
      -- Customize which characters to map for which completion kinds
      -- By default, this handles '()', '[]', '{}' for Function, Method, etc.
  })
)
