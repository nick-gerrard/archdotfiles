-- ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    -- Ensure the nested tables exist before we try to modify them
    opts.filesystem = opts.filesystem or {}
    opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}

    -- Now we can safely merge our settings
    vim.tbl_deep_extend("force", opts.filesystem.filtered_items, {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
    })
  end,
}
