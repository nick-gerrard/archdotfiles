-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add svelte to the list of languages
    vim.list_extend(opts.ensure_installed, {
      "svelte",
    })
  end,
}
