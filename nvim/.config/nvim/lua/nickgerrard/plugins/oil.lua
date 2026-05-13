return {
  "stevearc/oil.nvim",
  opts = {
    use_default_keymaps = true,
    keymaps = {
      ["q"] = "actions.close"
    },
    float = {
      padding = 2,
      max_width = 60,
      max_height = 20,
      border = "rounded",
      win_options = {
        winblend = 0,
        winhighlight = "FloatBorder:FloatBorder",
      },
    },
  },
  keys = {
    { "-", "<cmd>Oil --float<cr>", desc = "Open Oil" }
  }
}
