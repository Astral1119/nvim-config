return {
  {
    -- currently prefer this over 'MeanderingProgrammer/render-markdown.nvim'
    -- https://github.com/OXY2DEV/markview.nvim/wiki
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "mdx" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      latex = {
        enable = true,
      },
      preview = {
        enable = true,
        debounce = 100,
        -- hybrid_modes: render everything EXCEPT the current line while editing
        hybrid_modes = { "n", "i", "v" },
        linewise_hybrid_mode = true,
      },
      markdown = {
        list_items = {
          enable = false,
        }
      },
    }
  },

  {
    'jakewvincent/mkdnflow.nvim',
    ft = { "markdown", "mdx" },
    opts = {
      -- Use markdown_oxide for links where possible; mkdnflow handles
      -- list/checkbox/table utilities that oxide doesn't cover.
      modules = {
        bib        = false, -- we don't use bibtex in markdown
        buffers    = true,
        conceal    = true,
        cursor     = true,
        folds      = false, -- let nvim-ufo handle folds
        links      = true,
        lists      = true,
        maps       = true,
        paths      = true,
        tables     = true,
        yaml       = false, -- only used for bib paths; disabled with bib
      },
      links = {
        -- Don't transform link text on creation
        transform_explicit = false,
        -- Conceal link URLs in normal mode (markview handles this better, disable)
        conceal = false,
      },
      tables = {
        -- Auto-format tables on leaving a cell
        auto_extend_rows = false,
      },
      -- Default mappings (all <localleader>-prefixed or intuitive):
      -- <CR>        follow link / create link
      -- <BS>        go back
      -- <Tab>       next link in buffer
      -- <S-Tab>     previous link in buffer
      -- <leader>p   paste as link (from clipboard)
      -- <C-Space>   toggle checkbox
      -- ]]/[[       next/prev heading
    },
  },
}
