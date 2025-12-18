return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          check_outdated_packages_on_open = true,
          border = "rounded",
        },
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
      })

      -- Install tools directly through Mason
      local registry = require("mason-registry")
      local ensure_installed = {
        -- LSP
        "lua-language-server",
        "typescript-language-server",
        "rust-analyzer",
        "tailwindcss-language-server",
        "pyright",
        -- Formatters & Linters
        "prettier",
        "isort",
        "black",
        "pylint",
        "eslint_d"
      }

      -- Ensure Mason registry is ready
      registry.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local p = registry.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)

      -- Ensure executables are in PATH
      vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      -- Server specific settings
      local servers = {
        lua_ls = {
          cmd = { mason_path .. "/bin/lua-language-server" }
        },
        pyright = {},
        ts_ls = {
          cmd = { mason_path .. "/bin/typescript-language-server", "--stdio" },
          filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          settings = {
            javascript = {
              validate = {
                enable = false,
                semanticValidation = false,
              },
            },
            typescript = {
              validate = {
                enable = true,
              },
            },
          },
        },
        rust_analyzer = {
          cmd = { mason_path .. "/bin/rust-analyzer" }
        },
        tailwindcss = {
          cmd = { mason_path .. "/bin/tailwindcss-language-server", "--stdio" }
        },
      }

      -- Setup each server
      for server_name, server_settings in pairs(servers) do
        lspconfig[server_name].setup(server_settings)
      end

      -- Keymaps
      vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { noremap = true, silent = true })
    end
  }
}
