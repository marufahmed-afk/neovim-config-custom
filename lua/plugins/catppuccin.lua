return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
      },
    },
  },
  config = function()
    require("catppuccin").setup({
      flavor = "mocha", -- Optional: Specify the default flavor
      color_overrides = {
        all = {
          text = "#ffffff",
        },
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    })
    vim.cmd.colorscheme "catppuccin-mocha"
  end
}
