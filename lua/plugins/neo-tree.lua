return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", 
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set('n', '<leader>e', function()
        local neotree_open = false

        -- Check if a Neotree window is open
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
          if buf_ft == 'neo-tree' then
            neotree_open = true
            break
          end
        end

        if neotree_open then
          -- Close Neotree if already open
          vim.cmd('Neotree close')
        else
          -- Open Neotree if not open
          vim.cmd('Neotree filesystem reveal right')
        end
      end, {})
    end
}
