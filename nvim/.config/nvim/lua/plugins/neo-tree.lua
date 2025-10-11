-- Location: ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- This is the default, but good to keep it explicit
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
