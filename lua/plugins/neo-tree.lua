return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Keymapping for toggling Neo-tree
    vim.keymap.set('n', '<leader>e', function()
      local neotree_open = false

      -- Check if a Neo-tree window is open
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == 'neo-tree' then
          neotree_open = true
          break
        end
      end

      if neotree_open then
        -- Close Neo-tree if already open
        vim.cmd('Neotree close')
      else
        -- Open Neo-tree if not open
        vim.cmd('Neotree filesystem reveal right')
      end
    end, {})

    -- Configure Neo-tree
    require("neo-tree").setup({
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        position = "right", -- Ensure Neo-tree opens on the right
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.fn.system({ "xdg-open", path }) -- Adjust for macOS or Windows
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- If nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
      event_handlers = {
        {
          event = "file_moved",
          handler = function(data)
            print("File moved from", data.source, "to", data.destination)
          end,
        },
        {
          event = "file_renamed",
          handler = function(data)
            print("File renamed from", data.source, "to", data.destination)
          end,
        },
      },
    })

    -- Auto-close Neo-tree when exiting Neovim
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        vim.cmd("Neotree close")
      end,
    })

    -- Refresh Neo-tree git_status after lazygit closes
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}

