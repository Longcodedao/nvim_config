return {
'nosduco/remote-sshfs.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Required for the picker and remote search features
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('remote-sshfs').setup({

      connections = {
        ssh_configs = { -- which ssh configs to parse for hosts list
          vim.fn.expand "$HOME" .. "/.ssh/config",
          "/etc/ssh/ssh_config",
          -- "/path/to/custom/ssh_config"
        },

        ssh_known_hosts = vim.fn.expand "$HOME" .. "/.ssh/known_hosts",
        -- NOTE: Can define ssh_configs similarly to include all configs in a folder
        -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
        sshfs_args = { -- arguments to pass to the sshfs command
          "-o reconnect",
          "-o ConnectTimeout=5",
        },
      },

      mounts = {
        base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
        unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
      },
    })
    -- Optionally load the telescope extension for remote searching
    require('telescope').load_extension('remote-sshfs')
  end
}
