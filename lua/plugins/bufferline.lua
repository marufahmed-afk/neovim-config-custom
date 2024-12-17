-- return {
--   'akinsho/bufferline.nvim',
--   version = "*",
--   dependencies = 'nvim-tree/nvim-web-devicons',
--   config = function()
--     vim.opt.termguicolors = true
--     require("bufferline").setup{}
--   end
-- }
--
return {
  "akinsho/bufferline.nvim",
  event = "BufWinEnter",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Current Buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "[B", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Prev" },
    { "]B", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Next" },
  },
  opts = {
    options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end, diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diagnostics)
        local icons = { Error = "", Warn = "", Info = "", Hint = "" }
        return (diagnostics.error and icons.Error .. diagnostics.error .. " " or "")
          .. (diagnostics.warning and icons.Warn .. diagnostics.warning or "")
      end,
      offsets = {
        { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "left" },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Auto-update bufferline when buffers are modified
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(require("bufferline").refresh)
        end)
      end,
    })
  end,
}

