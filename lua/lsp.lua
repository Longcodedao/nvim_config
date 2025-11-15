-- 1. DEFINE THE COMMON ON_ATTACH FUNCTION
-- This function runs every time an LSP server attaches to a buffer (file).
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    -- Disable Neovim's default format-on-save if you are using a separate formatter like 'conform.nvim'
    -- client.server_capabilities.documentFormattingProvider = false 

    -- Set buffer-local options
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'

    -- Define keymap options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Keymaps for LSP functionality
    -- You can customize these to your preference
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)       -- Go to Definition
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)      -- Go to Declaration
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)             -- Hover Documentation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)   -- Go to Implementation
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Show Signature Help
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts) -- Go to Type Definition
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)   -- Rename symbol
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code Action
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)       -- Find References
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)     -- Go to previous diagnostic
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)     -- Go to next diagnostic
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- Open floating diagnostic window
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- Set quickfix list

    -- Special Ruff handling to disable hover, as Pyright is better for that
    if client.name == 'ruff' then
        client.server_capabilities.hoverProvider = false
    end
end

vim.lsp.config('pyright',{
  on_attach = on_attach,
  filetypes = { 'python' },
  
  -- 1. How the LSP determines the project root (crucial for imports)
  root_markers = {"pyproject.toml", "setup.cfg", "setup.py", ".git"}, 
  capabilities = capabilities, 

  settings = {
        python = {
            analysis = {
                -- Your existing setting
                typeCheckingMode = "basic", 
                
                -- Control which files are analyzed for errors/warnings
                diagnosticMode = "workspace", -- or "workspace" to check all files

                -- Control Python environment discovery
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                
                -- Fine-grained diagnostic control (overrides typeCheckingMode)
                diagnosticSeverityOverrides = {
                    -- Treat unused imports as warnings instead of errors
                    reportUnusedImport = "warning",
                    -- Ignore "reportMissingTypeStubs" (missing type hints for libraries)
                    reportMissingTypeStubs = "none", 
                    -- Treat unused variables as hints (less intrusive)
                    reportUnusedVariable = "information",
                },

                ignore = { '*' },
                
                -- Add paths to look for custom modules (relative to root_dir)
                -- extraPaths = { "src", "stubs" },
            },

        pyright = {
            disableOrganizeImports = true,
          },
        },


    },
})

-- 3. RUFF SETUP (Linting & Formatting/Organize Imports)
vim.lsp.config('ruff', {
    on_attach = on_attach, -- Use the same keymaps
    filetypes = { 'python' },

    capabilities = capabilities,
    
    -- Ruff-specific options
    init_options = {
        settings = {
            -- Enable Ruff to run on every key stroke
            lint = {
                run = 'onType',
            },
            -- Enable Organize Imports via Ruff
            organizeImports = true,
            -- Enable Ruff formatting
            format = true,
            -- If you want Ruff to automatically apply 'safe' fixes on save:
            -- fixAll = true, 
        },
    },
  
})

