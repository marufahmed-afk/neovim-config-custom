return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    file_types = { "markdown" },
    completions = { lsp = { enabled = true } },
    latex = { enabled = false },
    heading = { sign = false },
    code = { sign = false, width = "block", min_width = 60 },
  },
}
