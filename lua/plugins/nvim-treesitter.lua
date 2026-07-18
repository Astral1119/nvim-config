-- nvim-treesitter `main` branch (rewrite, Neovim 0.11+/0.12 compatible).
-- The old `master` branch is frozen and crashes on 0.12 because directives
-- like `set-lang-from-info-string!` now receive quantified-capture lists.
--
-- Differences from master:
--   * No more `require('nvim-treesitter.configs').setup(opts)`.
--   * No `highlight`/`indent` options — enable per-buffer with
--     `vim.treesitter.start()` and `nvim-treesitter.indentexpr()`.
--   * No `ensure_installed` option — call `require('nvim-treesitter').install{}`.
--   * Custom parsers register via `require('nvim-treesitter.parsers').<name> = {...}`,
--     ideally inside a `User TSUpdate` autocmd so `:TSUpdate` sees them.
--   * Cannot be lazy-loaded.
--
-- Parsers are compiled locally and require the `tree-sitter` CLI on PATH.

local ensure_installed = {
  -- core
  "lua", "vim", "vimdoc", "query",
  -- systems
  "c", "cpp", "rust",
  -- web
  "javascript", "typescript", "tsx", "html", "css", "json",
  -- scripting / data
  "python", "bash",
  -- documents
  "markdown", "markdown_inline", "latex", "yaml",
  -- proof assistants
  "lean",
  -- custom / other
  "sql", "gsheets", "lattice",
}

-- Filetypes that should get treesitter highlighting + indent.
-- Includes filetypes whose parser is registered under a different name
-- via `vim.treesitter.language.register` (e.g. mdx → markdown).
local ts_filetypes = {
  "lua", "vim", "help", "query",
  "c", "cpp", "rust",
  "javascript", "typescript", "typescriptreact", "html", "css", "json",
  "python", "bash", "sh",
  "markdown", "mdx", "latex", "tex", "yaml",
  "lean",
  "sql", "gsheets", "lattice",
}

local function register_custom_parsers()
  local parsers = require("nvim-treesitter.parsers")

  parsers.gsheets = {
    install_info = {
      url = "https://github.com/Astral1119/tree-sitter-gsheets",
      branch = "main",
    },
  }

  -- `lean` is not in nvim-treesitter's main-branch registry; register the
  -- grammar from lean.nvim's author so :TSUpdate / install can build it.
  parsers.lean = {
    install_info = {
      url = "https://github.com/Julian/tree-sitter-lean",
      branch = "main",
    },
  }

  local lattice_parser_dir = vim.fn.expand("~/sandbox/current/lattice/editors/tree-sitter-lattice")
  if vim.fn.isdirectory(lattice_parser_dir) == 1 then
    parsers.lattice = {
      install_info = {
        path = lattice_parser_dir,
      },
    }
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      -- Filetype detection (kept here so it lands before any buffers open).
      vim.filetype.add({
        extension = {
          gse = "gsheets",
          gsf = "gsheets",
          gsheets = "gsheets",
          mdx = "mdx",
        },
      })

      -- Make `mdx` use the markdown parser.
      vim.treesitter.language.register("markdown", "mdx")

      -- Register custom parsers BOTH directly (so the immediate install call
      -- below sees them) AND inside the User TSUpdate autocmd (so subsequent
      -- :TSUpdate runs see them too).
      register_custom_parsers()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = register_custom_parsers,
      })

      if vim.fn.executable("tree-sitter") == 1 then
        -- setup() is optional on main; only needed to override install_dir.
        -- Async install of all desired parsers (filtering local-only ones
        -- whose source isn't checked out on this machine).
        local install_list = {}
        local has_lattice = vim.fn.isdirectory(
          vim.fn.expand("~/sandbox/current/lattice/editors/tree-sitter-lattice")
        ) == 1
        for _, p in ipairs(ensure_installed) do
          if p ~= "lattice" or has_lattice then
            table.insert(install_list, p)
          end
        end
        require("nvim-treesitter").install(install_list)
      else
        vim.notify(
          "tree-sitter CLI not found; run dots brew install to build parsers",
          vim.log.levels.WARN
        )
      end

      -- Enable highlight + indent per buffer for our chosen filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ts_filetypes,
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- Disable the plugin's default keymaps; we set our own below.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Selection (visual + operator-pending)
      local select_maps = {
        ["af"] = { "@function.outer",    "Around function" },
        ["if"] = { "@function.inner",    "Inside function" },
        ["aa"] = { "@parameter.outer",   "Around parameter" },
        ["ia"] = { "@parameter.inner",   "Inside parameter" },
        ["ac"] = { "@conditional.outer", "Around conditional" },
        ["ic"] = { "@conditional.inner", "Inside conditional" },
        ["ib"] = { "@code_cell.inner",   "Inside code block" },
        ["ab"] = { "@code_cell.outer",   "Around code block" },
      }
      for lhs, spec in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(spec[1], "textobjects")
        end, { desc = spec[2] })
      end

      -- Movement (normal + visual + operator-pending)
      local next_start = {
        ["]f"] = { "@function.outer",  "Next function" },
        ["]a"] = { "@parameter.outer", "Next parameter" },
        ["]b"] = { "@code_cell.inner", "Next code block" },
      }
      local prev_start = {
        ["[f"] = { "@function.outer",  "Previous function" },
        ["[a"] = { "@parameter.outer", "Previous parameter" },
        ["[b"] = { "@code_cell.inner", "Previous code block" },
      }
      for lhs, spec in pairs(next_start) do
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          move.goto_next_start(spec[1], "textobjects")
        end, { desc = spec[2] })
      end
      for lhs, spec in pairs(prev_start) do
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          move.goto_previous_start(spec[1], "textobjects")
        end, { desc = spec[2] })
      end

      -- Swap
      vim.keymap.set("n", "<leader>sbl", function() swap.swap_next("@code_cell.outer") end,
        { desc = "Swap code block with next" })
      vim.keymap.set("n", "<leader>sal", function() swap.swap_next("@parameter.outer") end,
        { desc = "Swap parameter with next" })
      vim.keymap.set("n", "<leader>sbh", function() swap.swap_previous("@code_cell.outer") end,
        { desc = "Swap code block with previous" })
      vim.keymap.set("n", "<leader>sah", function() swap.swap_previous("@parameter.outer") end,
        { desc = "Swap parameter with previous" })
    end,
  },
}
