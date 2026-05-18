return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true } end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local enabled_filetypes = {
        lua = true,
        python = true,
        javascript = true,
        html = true,
        typescript = true,
        htmldjango = true,
        sql = true,
        svelte = true,
        css = true,
        tsx = true,
        typescriptreact = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters = {
      prettier = {
        command = function()
          local local_prettier = vim.fn.findfile('node_modules/.bin/prettier', vim.fn.getcwd() .. ';')
          if local_prettier ~= '' then
            return local_prettier
          end
          return 'prettier'
        end,
      },
    },
    formatters_by_ft = {
      python = { 'ruff_fix', 'ruff_format' },
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      html = { 'djlint', 'prettier' },
      htmldjango = { 'djlint', 'prettier' },
      sql = { 'sql-formatter' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      tsx = { 'prettier' },
      typescriptreact = { 'prettier' },
      -- rust = { "rustfmt" },
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
