vim.bo.commentstring = "-- %s"

local path = vim.api.nvim_buf_get_name(0)
local start = vim.fs.dirname(path)
local root = vim.fs.root(start, { "lakefile.lean", "lakefile.toml", "lean-toolchain" })

if root and vim.fn.executable("lake") == 1 then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

  vim.lsp.start({
    name = "lean",
    cmd = { "lake", "env", "lean", "--server" },
    root_dir = root,
    cmd_cwd = root,
    capabilities = capabilities,
  })
end
