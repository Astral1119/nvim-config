-- lua/plugins/lsp/oxide.lua

local oxide = {}

function oxide.on_attach(client, bufnr)
  -- CodeLens Support
  local function check_codelens_support()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
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
        local clients = vim.lsp.get_clients { name = "markdown_oxide" }

        if #clients == 0 then
          vim.notify("No ts_ls client found", vim.log.levels.ERROR)
          return
        end

        local cur_client = clients[1]

        cur_client:exec_cmd({ command = "jump", arguments = { input }, title = "" })
      end,
      { desc = 'Open daily note', nargs = "*" }
    )
  end
end

return oxide
