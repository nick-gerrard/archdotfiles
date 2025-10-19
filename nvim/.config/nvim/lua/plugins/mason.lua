-- Location: ~/.config/nvim/lua/plugins/mason.lua

return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- python
      "pyright",
      "ruff",
      "guitui",

      -- web dev
      "typescript-language-server",
      "svelte-language-server",
      "termux-language-server",
      "tailwind-language-server",

      -- lua
      "lua-language-server",
    },
  },
}
