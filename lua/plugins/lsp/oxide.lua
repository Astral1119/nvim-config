-- lua/plugins/lsp/oxide.lua

local oxide = {}

function oxide.on_attach(client, bufnr)
  -- CodeLens Support
  local function check_codelens_support()
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    for _, c in ipairs(clients) do
      if c.server_capabilities.codeLensProvider then
        return true
      end
    end
    return false
  end

  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
    buffer = bufnr,
    callback = function()
      if check_codelens_support() then
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end
    end
  })

  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

  -- Markdown Oxide Daily Notes
  if client.name == "markdown_oxide" then
    vim.api.nvim_create_user_command(
      "Daily",
      function(args)
        local input = args.args
        vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
      end,
      { desc = 'Open daily note', nargs = "*" }
    )
  end
end

return oxide
