-- Location: ~/.config/nvim/lua/plugins/mason.lua

return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- python
      "pyright",
      "ruff",

      -- web dev
      "typescript-language-server",
      "svelte-language-server",
      "tailwindcss-language-server",

      -- lua
      "lua-language-server",
    },
  },
}
