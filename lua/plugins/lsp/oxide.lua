-- lua/plugins/lsp/oxide.lua

local oxide = {}

function oxide.on_attach(client, bufnr)
  -- CodeLens: enable auto-refresh for this buffer if the server supports it.
  -- Replaces the old `codelens.refresh` + manual TextChanged/CursorHold loop;
  -- `codelens.enable(true, ...)` registers its own refresh autocmds internally.
  if client.server_capabilities.codeLensProvider then
    vim.lsp.codelens.enable(true, { bufnr = bufnr })
  end

  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

  -- Markdown Oxide Daily Notes
  if client.name == "markdown_oxide" then
    vim.api.nvim_create_user_command(
      "Daily",
      function(args)
        local input = args.args
        local clients = vim.lsp.get_clients { name = "markdown_oxide" }

        if #clients == 0 then
          vim.notify("No markdown_oxide client found", vim.log.levels.ERROR)
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
